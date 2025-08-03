import 'package:cinemax/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyCinemax());
}

class MyCinemax extends StatelessWidget {
  const MyCinemax({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: TestGridView());
      },
    );
  }
}
