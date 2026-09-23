import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _jost({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.jost(
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display
  static TextStyle get display => _jost(size: 32, weight: FontWeight.w700);

  // Headings
  static TextStyle get h1 => _jost(size: 28, weight: FontWeight.w700);
  static TextStyle get h2 => _jost(size: 24, weight: FontWeight.w700);
  static TextStyle get h3 => _jost(size: 20, weight: FontWeight.w600);
  static TextStyle get h4 => _jost(size: 18, weight: FontWeight.w600);

  // Body
  static TextStyle get bodyLg =>
      _jost(size: 16, weight: FontWeight.w400, height: 1.6);
  static TextStyle get bodyMd =>
      _jost(size: 14, weight: FontWeight.w400, height: 1.5);
  static TextStyle get bodySm =>
      _jost(size: 12, weight: FontWeight.w400, height: 1.4);

  // Semi-bold body
  static TextStyle get bodyLgSemi => _jost(size: 16, weight: FontWeight.w600);
  static TextStyle get bodyMdSemi => _jost(size: 14, weight: FontWeight.w600);
  static TextStyle get bodySmSemi => _jost(size: 12, weight: FontWeight.w600);

  // Special
  static TextStyle get caption =>
      _jost(size: 11, weight: FontWeight.w400, color: AppColors.textSecondary);
  static TextStyle get label =>
      _jost(size: 12, weight: FontWeight.w500, letterSpacing: 0.5);
  static TextStyle get button =>
      _jost(size: 15, weight: FontWeight.w600, color: AppColors.white);
  static TextStyle get price =>
      _jost(size: 18, weight: FontWeight.w700, color: AppColors.primary);
  static TextStyle get priceOld => _jost(
    size: 13,
    weight: FontWeight.w400,
    color: AppColors.gray400,
    letterSpacing: 0.2,
  );
}
