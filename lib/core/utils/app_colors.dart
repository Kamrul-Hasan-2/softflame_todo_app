import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  // Main Colors
  static const Color primaryColor = Color(0xFF5053EB);
  static const Color secondaryColor = Color(0xFF28A745);
  static const Color appBackground = Color(0xFFFFFFFF);
  static const Color successColor = Color(0xFF28A745);
  static const Color errorColor = Color(0xFFDC3545);

  // Neutral & Tints
  static const Color neutralDark = Color(0xFF2D3E4E);
  static const Color subtleTint = Color(0xFFF0F9F6);
  static const Color primaryTransparent = Color(0x1A5053EB);
  static const Color successTransparent = Color(0x1A28A745);
  static const Color offColor = Color(0xFFCFCFCF);

  // Borders & Dividers
  static const Color borderColor = Color(0xFFCDCDCD);
  static const Color dividerColor = Color(0xFFCDCDCD);

  // Text Colors
  static const Color primaryTextColor = Color(0xFF2D3E4E);
  static const Color secondaryTextColor = Color(0xFF2D3E4E);
  static const Color lowTextColor = Color(0xFF9C9CA7);

  // Social Media Colors
  static const Color facebookBlue = Color(0xFF415893);
  static const Color googleBlue = Color(0xFF5A94EE);

  // Basic Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Legacy color aliases (mapped to palette colors)
  static const Color colorF14F4A = errorColor; // Error
  static const Color color80C2A0 = secondaryColor; // Success/Secondary
  static const Color offWhiteColor = appBackground; // Off White
  static const Color colorE0E0E0 = dividerColor; // Divider
  static const Color colorBBBBBB = dividerColor; // Medium Grey
  static const Color color0D2238 = primaryTextColor; // Dark Text
  static const Color color888E9D = lowTextColor; // Low Text
  static const Color colorFBFBFB = appBackground; // Almost White
  static const Color colorF5F5F5 = appBackground; // Light Background
}