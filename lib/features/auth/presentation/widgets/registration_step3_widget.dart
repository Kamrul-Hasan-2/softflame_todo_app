import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/validators.dart';
import 'common_button.dart';
import 'common_text_field.dart';

class RegistrationStep3Widget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController pinController;
  final TextEditingController confirmPinController;
  final VoidCallback onSetPIN;

  const RegistrationStep3Widget({
    super.key,
    required this.formKey,
    required this.pinController,
    required this.confirmPinController,
    required this.onSetPIN,
  });

  @override
  State<RegistrationStep3Widget> createState() =>
      _RegistrationStep3WidgetState();
}

class _RegistrationStep3WidgetState extends State<RegistrationStep3Widget> {
  bool _isPinVisible = false;
  bool _isConfirmPinVisible = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfigs.getProportionateScreenWidth(24),
        ),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),

              // Title
              Text(
                'Create Security PIN',
                style: AppStyles.headingTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.color0D2238,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(8)),

              // Subtitle
              Text(
                'A Simple 6-digit code to lock you account',
                style: AppStyles.normalTextStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.color888E9D,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(32)),

              // Set PIN Label
              Text(
                'Set your PIN',
                style: AppStyles.normalTextStyle.copyWith(
                  fontSize: 16,
                  color: AppColors.color0D2238,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),

              // Set PIN Input
              CommonTextField(
                controller: widget.pinController,
                hintText: "123456",
                keyboardType: TextInputType.number,
                obscureText: !_isPinVisible,
                validator: Validators.validate6DigitPin,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPinVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.color888E9D,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPinVisible = !_isPinVisible;
                    });
                  },
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(20)),

              // Rewrite PIN Label
              Text(
                'Rewrite your PIN',
                style: AppStyles.normalTextStyle.copyWith(
                  fontSize: 16,
                  color: AppColors.color0D2238,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),

              // Rewrite PIN Input
              CommonTextField(
                controller: widget.confirmPinController,
                hintText: "123456",
                keyboardType: TextInputType.number,
                obscureText: !_isConfirmPinVisible,
                validator: (value) => Validators.validateConfirmPin(
                  value,
                  widget.pinController.text,
                  length: 6,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPinVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.color888E9D,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPinVisible = !_isConfirmPinVisible;
                    });
                  },
                ),
              ),

              SizedBox(height: SizeConfigs.getProportionateScreenHeight(32)),

              // Set PIN Button
              CommonButton(
                onPressed: widget.onSetPIN,
                text: 'Set PIN  →',
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
