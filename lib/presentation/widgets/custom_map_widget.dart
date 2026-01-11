import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import '../../core/themes/app_colors.dart';

enum MapMode {
  display, // For home screen - simple display and tap updates
  selection, // For select digipin screen - interactive selection with markers
}

class MapData {
  final String coordinates;
  final geo.Position? location;
  final Point? selectedPoint;

  MapData({
    required this.coordinates,
    this.location,
    this.selectedPoint,
  });
}

class CustomMapController {
  _CustomMapWidgetState? _state;

  void _attach(_CustomMapWidgetState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  Future<void> moveToCurrentLocation() async {
    await _state?.moveToCurrentLocation();
  }

  MapData? get currentMapData => _state?.currentMapData;
}

class CustomMapWidget extends StatefulWidget {
  final MapMode mode;
  final MapData? initialData;
  final Function(MapData)? onLocationUpdate;
  final Function(MapData)? onTapUpdate;
  final Function(MapData)? onLocationSelected;
  final CustomMapController? controller;
  final Widget? overlayContent;
  final double initialZoom;

  const CustomMapWidget({
    super.key,
    required this.mode,
    this.initialData,
    this.onLocationUpdate,
    this.onTapUpdate,
    this.onLocationSelected,
    this.controller,
    this.overlayContent,
    this.initialZoom = 14.0,
  });

  @override
  State<CustomMapWidget> createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  static bool _isMapboxInitialized = false;

  MapboxMap? _mapboxMap;
  geo.Position? _currentLocation;
  Point? _selectedLocation;
  String _currentCoordinates = '10.27706540, 76.37878287';
  bool _showSelectedMarkerPopup = false;

  // Annotation managers for different marker types
  CircleAnnotationManager? _circleAnnotationManager;
  CircleAnnotationManager? _currentLocationCircleManager;
  CircleAnnotationManager? _accuracyCircleManager;
  List<CircleAnnotation> _selectedLocationCircles = [];
  CircleAnnotation? _currentLocationCircle;
  CircleAnnotation? _accuracyCircle;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _initializeMapbox();
    _initializeWithData();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    widget.controller?._detach();
    super.dispose();
  }

  void _initializeMapbox() {
    if (!_isMapboxInitialized) {
      MapboxOptions.setAccessToken(
        'pk.eyJ1Ijoic29saWRhcHBzIiwiYSI6ImNtZGQwaXAzczAycmoyb3BzMWkyZm9pcXMifQ.B3j0rVy2fyaaljWCfGQj5Q',
      );
      _isMapboxInitialized = true;
    }
  }

  void _initializeWithData() {
    if (widget.initialData != null) {
      _currentCoordinates = widget.initialData!.coordinates;
      _currentLocation = widget.initialData!.location;
      _selectedLocation = widget.initialData!.selectedPoint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Container
        Positioned.fill(
          child: MapWidget(
            key: ValueKey('customMapWidget_${widget.mode.name}'),
            cameraOptions: CameraOptions(
              center: _getCurrentMapCenter(),
              zoom: widget.initialZoom,
            ),
            onMapCreated: _onMapCreated,
            onTapListener: _onMapTap,
          ),
        ),

        // Mode-specific overlays
        if (widget.mode == MapMode.selection &&
            _showSelectedMarkerPopup &&
            _selectedLocation != null)
          _buildSelectedLocationPopup(),

        // Custom overlay content from parent
        if (widget.overlayContent != null) widget.overlayContent!,
      ],
    );
  }

  Widget _buildSelectedLocationPopup() {
    return Positioned(
      top: 200.h,
      right: 20.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.lightCardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.lightPrimary.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey400.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Selected Location',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.lightTextSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showSelectedMarkerPopup = false;
                    });
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              _currentCoordinates,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.lightPrimary,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    await _setupAnnotationManagers();
    // Wait for map to be fully loaded
    await Future.delayed(const Duration(milliseconds: 500));
    await _addCurrentLocationMarker();
  }

  void _onMapTap(MapContentGestureContext context) async {
    if (widget.mode == MapMode.selection) {
      await _selectLocationOnMap(context.point);
    } else if (widget.mode == MapMode.display) {
      await _updateLocationOnTap(context.point);
    }
  }

  // Core location logic
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      // Check location permissions
      geo.LocationPermission permission =
          await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }

      if (permission == geo.LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        return;
      }

      // Get current position
      geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = position;
        _currentCoordinates =
            '${position.latitude.toStringAsFixed(8)}, ${position.longitude.toStringAsFixed(8)}';
      });

      // Add current location marker
      await _addCurrentLocationMarker();

      // Notify parent of location update
      _notifyLocationUpdate();

      print('Current location: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Point _getCurrentMapCenter() {
    if (_currentLocation != null) {
      return Point(
        coordinates: Position(
          _currentLocation!.longitude,
          _currentLocation!.latitude,
        ),
      );
    }
    // Default to Kochi, Kerala
    return Point(coordinates: Position(76.378787287, 10.27706540));
  }

  // Selection mode specific methods
  Future<void> _selectLocationOnMap(Point coordinates) async {
    if (widget.mode != MapMode.selection) return;

    try {
      setState(() {
        _selectedLocation = coordinates;
        _currentCoordinates =
            '${coordinates.coordinates.lat.toStringAsFixed(8)}, ${coordinates.coordinates.lng.toStringAsFixed(8)}';
        _showSelectedMarkerPopup = true;
      });

      // Add blue marker for selected location
      await _addSelectedLocationMarker(coordinates);

      // Notify parent
      _notifyLocationSelected();

      print('Selected location: $_currentCoordinates');
    } catch (e) {
      print('Location selection failed: $e');
    }
  }

  // Display mode specific methods
  Future<void> _updateLocationOnTap(Point coordinates) async {
    if (widget.mode != MapMode.display) return;

    try {
      setState(() {
        _currentCoordinates =
            '${coordinates.coordinates.lat.toStringAsFixed(8)}, ${coordinates.coordinates.lng.toStringAsFixed(8)}';
      });

      // Update marker position for display mode
      await _addCurrentLocationMarkerAtPosition(coordinates);

      // Notify parent
      _notifyTapUpdate();

      print('Updated location: $_currentCoordinates');
    } catch (e) {
      print('Error updating location: $e');
    }
  }

  // Annotation management
  Future<void> _setupAnnotationManagers() async {
    if (_mapboxMap != null) {

      if (widget.mode == MapMode.selection) {
        _circleAnnotationManager = await _mapboxMap!.annotations
            .createCircleAnnotationManager();
      } else if (widget.mode == MapMode.display) {
        _currentLocationCircleManager = await _mapboxMap!.annotations
            .createCircleAnnotationManager();
        _accuracyCircleManager = await _mapboxMap!.annotations
            .createCircleAnnotationManager();
      }
    }
  }

  Future<void> _addCurrentLocationMarker() async {
    if (_currentLocation == null) return;

    final markerPosition = Point(
      coordinates: Position(
        _currentLocation!.longitude,
        _currentLocation!.latitude,
      ),
    );

    if (widget.mode == MapMode.selection && _circleAnnotationManager != null) {
      // Add red circle for current location in selection mode
      try {
        await _circleAnnotationManager!.create(
          CircleAnnotationOptions(
            geometry: markerPosition,
            circleRadius: 10.0,
            circleColor: 0xFFFF0000, // Red color for current location
            circleStrokeColor: 0xFFFFFFFF, // White border
            circleStrokeWidth: 2.0,
            circleOpacity: 0.8,
          ),
        );
      } catch (e) {
        print('Error adding current location circle marker: $e');
      }
    } else if (widget.mode == MapMode.display &&
        _currentLocationCircleManager != null &&
        _accuracyCircleManager != null) {
      // Add visible blue circle for current location in display mode
      try {
        // Clear existing markers
        if (_currentLocationCircle != null) {
          await _currentLocationCircleManager!.delete(_currentLocationCircle!);
        }
        if (_accuracyCircle != null) {
          await _accuracyCircleManager!.delete(_accuracyCircle!);
        }

        // Add outer accuracy circle (light blue, semi-transparent)
        final accuracyRadius = _currentLocation!.accuracy / 2; // Convert meters to approximate radius
        _accuracyCircle = await _accuracyCircleManager!.create(
          CircleAnnotationOptions(
            geometry: markerPosition,
            circleRadius: accuracyRadius.clamp(15.0, 50.0),
            circleColor: 0x332196F3, // Light blue with transparency
            circleStrokeColor: 0x882196F3, // Semi-transparent blue border
            circleStrokeWidth: 1.5,
            circleOpacity: 0.3,
          ),
        );

        // Add inner circle marker (solid blue dot)
        _currentLocationCircle = await _currentLocationCircleManager!.create(
          CircleAnnotationOptions(
            geometry: markerPosition,
            circleRadius: 8.0,
            circleColor: 0xFF2196F3, // Blue color for user location
            circleStrokeColor: 0xFFFFFFFF, // White border
            circleStrokeWidth: 3.0,
            circleOpacity: 1.0,
          ),
        );
      } catch (e) {
        print('Error adding current location circle marker: $e');
      }
    }
  }

  Future<void> _addCurrentLocationMarkerAtPosition(Point position) async {
    if (widget.mode != MapMode.display ||
        _currentLocationCircleManager == null ||
        _accuracyCircleManager == null)
      return;

    try {
      // Clear existing markers
      if (_currentLocationCircle != null) {
        await _currentLocationCircleManager!.delete(_currentLocationCircle!);
      }
      if (_accuracyCircle != null) {
        await _accuracyCircleManager!.delete(_accuracyCircle!);
      }

      // Add outer accuracy circle
      final accuracyRadius = _currentLocation?.accuracy ?? 20.0;
      _accuracyCircle = await _accuracyCircleManager!.create(
        CircleAnnotationOptions(
          geometry: position,
          circleRadius: (accuracyRadius / 2).clamp(15.0, 50.0),
          circleColor: 0x332196F3,
          circleStrokeColor: 0x882196F3,
          circleStrokeWidth: 1.5,
          circleOpacity: 0.3,
        ),
      );

      // Add inner circle marker at tapped position
      _currentLocationCircle = await _currentLocationCircleManager!.create(
        CircleAnnotationOptions(
          geometry: position,
          circleRadius: 8.0,
          circleColor: 0xFF2196F3, // Blue color
          circleStrokeColor: 0xFFFFFFFF, // White border
          circleStrokeWidth: 3.0,
          circleOpacity: 1.0,
        ),
      );
    } catch (e) {
      print('Error updating marker position: $e');
    }
  }

  Future<void> _addSelectedLocationMarker(Point position) async {
    if (widget.mode != MapMode.selection || _circleAnnotationManager == null)
      return;

    try {
      
      // Clear previous selected markers
      if (_selectedLocationCircles.isNotEmpty) {
        await _circleAnnotationManager!.deleteAll();
        _selectedLocationCircles.clear();
        // Re-add current location marker
        await _addCurrentLocationMarker();
      }

      // Add blue circle for selected location
      final circleAnnotation = await _circleAnnotationManager!.create(
        CircleAnnotationOptions(
          geometry: position,
          circleRadius: 10.0,
          circleColor: 0xFF0000FF, // Blue color for selected location
          circleStrokeColor: 0xFFFFFFFF, // White border
          circleStrokeWidth: 2.0,
          circleOpacity: 0.8,
        ),
      );

      // ignore: unnecessary_null_comparison
      if (circleAnnotation != null) {
        _selectedLocationCircles.add(circleAnnotation);
      }
    } catch (e) {
      print('Error adding selected location marker: $e');
    }
  }

  // Public methods for external control
  Future<void> moveToCurrentLocation() async {
    // First, get the latest location
    await _getCurrentLocation();

    if (_currentLocation != null && _mapboxMap != null) {
      final currentPoint = Point(
        coordinates: Position(
          _currentLocation!.longitude,
          _currentLocation!.latitude,
        ),
      );

      // Animate camera to current location
      await _mapboxMap!.easeTo(
        CameraOptions(
          center: currentPoint,
          zoom: 16.0,
        ),
        MapAnimationOptions(duration: 1000),
      );

      // Update based on mode
      if (widget.mode == MapMode.selection) {
        await _selectLocationOnMap(currentPoint);
      } else if (widget.mode == MapMode.display) {
        await _updateLocationOnTap(currentPoint);
      }
    }
  }

  // Notification methods
  void _notifyLocationUpdate() {
    if (widget.onLocationUpdate != null) {
      widget.onLocationUpdate!(
        MapData(
          coordinates: _currentCoordinates,
          location: _currentLocation,
        ),
      );
    }
  }

  void _notifyTapUpdate() {
    if (widget.onTapUpdate != null) {
      widget.onTapUpdate!(
        MapData(
          coordinates: _currentCoordinates,
          location: _currentLocation,
        ),
      );
    }
  }

  void _notifyLocationSelected() {
    if (widget.onLocationSelected != null) {
      widget.onLocationSelected!(
        MapData(
          coordinates: _currentCoordinates,
          location: _currentLocation,
          selectedPoint: _selectedLocation,
        ),
      );
    }
  }

  // Getter for current map data
  MapData get currentMapData => MapData(
    coordinates: _currentCoordinates,
    location: _currentLocation,
    selectedPoint: _selectedLocation,
  );
}
