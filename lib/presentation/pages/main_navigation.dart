import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';
import '../../core/utils/responsive_utils.dart';
import 'home_page.dart';
import 'activity_page.dart';
import 'fields_page.dart';
import 'profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = const [
    HomePage(),
    ActivityPage(),
    FieldsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavTap(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveUtils.isTabletOrLarger(context);

    // For tablets, we use the same bottom navigation for consistency
    // But the content will be responsive with better use of space
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: isTablet ? const NeverScrollableScrollPhysics() : null,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
