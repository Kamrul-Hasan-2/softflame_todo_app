import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class SnackbarUtils {
  /// Show a success snackbar with a green background
  static void showSuccess(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.normalTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: AppColors.successColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show an error snackbar with a red background
  static void showError(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.normalTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: AppColors.colorF14F4A,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show an info snackbar with a primary color background
  static void showInfo(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.normalTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show a warning snackbar with an orange background
  static void showWarning(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.normalTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show a custom snackbar with custom colors
  static void showCustom(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.normalTextStyle.copyWith(
            color: textColor ?? AppColors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
}
