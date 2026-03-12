import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import 'common_button.dart';

class RegistrationStep2Widget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> otpControllers;
  final List<FocusNode> otpFocusNodes;
  final String phoneNumber;
  final int resendTimer;
  final VoidCallback onVerify;
  final VoidCallback onResend;

  const RegistrationStep2Widget({
    super.key,
    required this.formKey,
    required this.otpControllers,
    required this.otpFocusNodes,
    required this.phoneNumber,
    required this.resendTimer,
    required this.onVerify,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfigs.getProportionateScreenWidth(24),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),

              // Title
              Text(
                'OTP Verification',
                style: AppStyles.headingTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.color0D2238,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(32)),

              // Label
              Text(
                'Verification code',
                style: AppStyles.normalTextStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.color888E9D,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),

              // OTP Input Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfigs.getProportionateScreenWidth(4),
                    ),
                    child: SizedBox(
                      width: SizeConfigs.getProportionateScreenWidth(45),
                      height: SizeConfigs.getProportionateScreenWidth(50),
                      child: TextFormField(
                        controller: otpControllers[index],
                        focusNode: otpFocusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: AppStyles.normalTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.color0D2238,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfigs.getProportionateScreenHeight(12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.colorE0E0E0,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.colorE0E0E0,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            otpFocusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            otpFocusNodes[index - 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),

              // Code sent message
              Center(
                child: Text(
                  'Code sent to +880 $phoneNumber',
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),

              // Resend Timer/Button
              Center(
                child: resendTimer > 0
                    ? Text(
                        'Didn\'t receive code? Resend in ${resendTimer}s',
                        style: AppStyles.normalTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.color888E9D,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : TextButton(
                        onPressed: onResend,
                        child: Text(
                          'Resend code',
                          style: AppStyles.normalTextStyle.copyWith(
                            fontSize: 13,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(32)),

              // Verify Button
              CommonButton(
                onPressed: onVerify,
                text: 'Verify',
                backgroundColor: AppColors.primaryColor,
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),
            ],
          ),
        ),
      ),
    );
  }
}
