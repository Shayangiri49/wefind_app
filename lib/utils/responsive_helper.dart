import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Screen size categories
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  // Screen dimensions
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Safe area dimensions
  static double safeAreaHeight(BuildContext context) =>
      MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;

  static double safeAreaWidth(BuildContext context) =>
      MediaQuery.of(context).size.width -
      MediaQuery.of(context).padding.left -
      MediaQuery.of(context).padding.right;

  // Responsive values
  static double responsiveValue(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }

  // Responsive padding
  static EdgeInsets responsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }

  // Responsive font sizes
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375; // Base width (iPhone 6/7/8)
    
    double baseFontSize = mobile;
    if (isDesktop(context) && desktop != null) {
      baseFontSize = desktop;
    } else if (isTablet(context) && tablet != null) baseFontSize = tablet;
    
    return (baseFontSize * scaleFactor).clamp(baseFontSize * 0.8, baseFontSize * 1.3);
  }

  // Responsive spacing
  static double responsiveSpacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = (screenWidth / 375).clamp(0.8, 1.5);
    
    double baseSpacing = mobile;
    if (isDesktop(context) && desktop != null) {
      baseSpacing = desktop;
    } else if (isTablet(context) && tablet != null) baseSpacing = tablet;
    
    return baseSpacing * scaleFactor;
  }

  // Responsive grid columns
  static int responsiveColumns(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 3;
    return 2;
  }

  // Responsive card width
  static double responsiveCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isDesktop(context)) return screenWidth * 0.25;
    if (isTablet(context)) return screenWidth * 0.4;
    return screenWidth * 0.88;
  }

  // Responsive card height
  static double responsiveCardHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (isDesktop(context)) return screenHeight * 0.6;
    if (isTablet(context)) return screenHeight * 0.55;
    return screenHeight * 0.54;
  }

  // Check if device is in landscape mode
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  // Get device pixel ratio
  static double devicePixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;

  // Responsive icon size
  static double responsiveIconSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = (screenWidth / 375).clamp(0.8, 1.4);
    
    double baseSize = mobile;
    if (isDesktop(context) && desktop != null) {
      baseSize = desktop;
    } else if (isTablet(context) && tablet != null) baseSize = tablet;
    
    return baseSize * scaleFactor;
  }

  // Responsive border radius
  static double responsiveBorderRadius(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = (screenWidth / 375).clamp(0.8, 1.3);
    
    double baseRadius = mobile;
    if (isDesktop(context) && desktop != null) {
      baseRadius = desktop;
    } else if (isTablet(context) && tablet != null) baseRadius = tablet;
    
    return baseRadius * scaleFactor;
  }

  // Get responsive layout constraints
  static BoxConstraints responsiveConstraints(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return BoxConstraints(
      maxWidth: screenWidth,
      maxHeight: screenHeight,
      minWidth: 0,
      minHeight: 0,
    );
  }

  // Responsive aspect ratio
  static double responsiveAspectRatio(BuildContext context) {
    if (isDesktop(context)) return 16 / 9;
    if (isTablet(context)) return 4 / 3;
    return 3 / 4; // Mobile portrait
  }
}
