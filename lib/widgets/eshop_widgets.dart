import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingAsset extends StatelessWidget {
  final String imagePath;
  const OnboardingAsset({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 390.w,
      height: 390.h,
    );
  }
}
