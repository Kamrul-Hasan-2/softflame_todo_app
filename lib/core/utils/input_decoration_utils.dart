import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class InputDecorationUtils {
  const InputDecorationUtils._();

  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  static InputDecoration build({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding,
    bool filled = true,
    Color fillColor = AppColors.colorFBFBFB,
    String? counterText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppStyles.normalTextStyle.copyWith(
        fontSize: 16,
        color: AppColors.colorBBBBBB,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: filled,
      fillColor: fillColor,
      counterText: counterText,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
      border: _outlineBorder(AppColors.colorE0E0E0),
      enabledBorder: _outlineBorder(AppColors.colorE0E0E0),
      focusedBorder: _outlineBorder(
        AppColors.primaryColor,
        width: 1.5,
      ),
      errorBorder: _outlineBorder(AppColors.colorF14F4A),
      focusedErrorBorder: _outlineBorder(
        AppColors.colorF14F4A,
        width: 1.5,
      ),
    );
  }

  static OutlineInputBorder _outlineBorder(
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
