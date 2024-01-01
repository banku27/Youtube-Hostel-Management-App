import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/theme/colors.dart';

class AppTextTheme {
  static TextStyle kAppBarStyle = GoogleFonts.inter(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.w600,
    fontSize: 26,
  );

  static TextStyle kLabelStyle = GoogleFonts.inter(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static TextStyle kPrimaryStyle = GoogleFonts.inter(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle khintStyle = GoogleFonts.poppins(
    color: const Color(0xFFA9A9B7),
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle kButtonStyle = GoogleFonts.inter(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static TextStyle kSocialTextStyle = GoogleFonts.roboto(
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 18.75,
  );

  static TextStyle dmTextStyle = GoogleFonts.poppins(
    color: const Color(0xff9091AD),
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle kChatStyle = GoogleFonts.manrope(
      color: const Color(0xFF0B2C47),
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 0);

  static TextTheme lightTextTheme = const TextTheme();
  static TextTheme darkTextTheme = const TextTheme();
}
