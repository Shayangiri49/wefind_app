import 'package:flutter/material.dart';

class AppColors {
  // Primary Orange Theme
  static const Color primaryOrange = Color(0xFFFF8C42);
  static const Color lightOrange = Color(0xFFFFA726);
  static const Color darkOrange = Color(0xFFFF7043);
  
  // Background Colors
  static const Color background = Color(0xFFFFFBF5);
  static const Color cardBackground = Color(0xFFFFF8F3);
  
  // Text Colors
  static const Color darkText = Color(0xFF2D3436);
  static const Color lightText = Color(0xFF636e72);
  static const Color whiteText = Colors.white;
  
  // Success Colors
  static const Color successGreen = Color(0xFF00B894);
  
  // Rating Colors
  static const Color starYellow = Color(0xFFFFD93D);
  
  // Product Colors
  static const Color priceGreen = Color(0xFF00B894);
  
  // Button Gradient
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF8C42), Color(0xFFFFA726)],
  );

  static const Color facebookBlue = Color(0xFF1877F3);
  static const Color twitterBlue = Color(0xFF1DA1F2);
  
  // Text colors
  static const Color subtleGray = Color(0xFF95A5A6);
  
  // Input field colors
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFill = Colors.white;
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x4CF7B327), Color(0xFFFFF7EA)],
  );
}

