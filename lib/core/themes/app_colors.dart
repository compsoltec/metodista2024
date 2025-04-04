import 'package:flutter/material.dart';

class AppColors {
  // New color palette
  static const darkPurple = Color(0xFF322938);
  static const sage = Color(0xFF89A194);
  static const gold = Color(0xFFCFC89A);
  static const copper = Color(0xFFCC883A);
  static const rust = Color(0xFFA14016);

  // Additional colors for modern UI
  static const white = Colors.white;
  static const black = Color(0xFF1A1A1A);
  static const cream = Color(0xFFFDF6E3);
  static const lightGray = Color(0xFFF5F5F5);
  static const darkGray = Color(0xFF4A4A4A);

  // Semantic colors
  static const backgroundColor = white;
  static const primaryColor = darkPurple;
  static const accentColor = copper;
  static const secondaryColor = sage;
  static const highlightColor = gold;
  static const emphasisColor = rust;
  static const cardColor = white;
  static const textPrimary = black;
  static const textSecondary = darkGray;

  // Gradient colors
  static const gradientStart = darkPurple;
  static const gradientEnd = Color(0xFF453A4D);

  // Overlay colors
  static final overlayLight = white.withOpacity(0.05);
  static final overlayDark = black.withOpacity(0.05);
}
