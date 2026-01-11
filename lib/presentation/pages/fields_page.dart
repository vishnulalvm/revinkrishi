import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldsPage extends StatelessWidget {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Fields'),
      ),
      body: Center(
        child: Text(
          'Fields Page',
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
