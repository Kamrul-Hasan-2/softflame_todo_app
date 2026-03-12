import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/validators.dart';
import 'common_button.dart';
import 'common_text_field.dart';

class RegistrationStep1Widget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final VoidCallback onSendOTP;

  const RegistrationStep1Widget({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.onSendOTP,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
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
                localizations.createAccount,
                style: AppStyles.headingTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(4)),

              // Subtitle
              Text(
                localizations.enterPhoneSignup,
                style: AppStyles.normalTextStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.lowTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),

              // Phone Number Label
              Text(
                localizations.phoneNumber,
                style: AppStyles.normalTextStyle.copyWith(
                  fontSize: 16,
                  color: AppColors.color0D2238,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              SizedBox(height: SizeConfigs.getProportionateScreenHeight(8)),

              // Phone Number Input
              CommonTextField(
                controller: phoneController,
                hintText: localizations.phoneHint,
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                prefixIcon: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+880',
                        style: AppStyles.normalTextStyle.copyWith(
                          fontSize: 16,
                          color: AppColors.color0D2238,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                          width: SizeConfigs.getProportionateScreenWidth(8)),
                      Container(
                        width: 2,
                        height: 54,
                        color: AppColors.colorE0E0E0,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),

              // Info Text
              Center(
                child: Text(
                  localizations.verificationCodeMessage,
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 13,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(320)),

              // Next Button
              CommonButton(
                onPressed: onSendOTP,
                text: '${localizations.next}  →',
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
