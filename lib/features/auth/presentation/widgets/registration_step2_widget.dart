import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/input_decoration_utils.dart';
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
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfigs.getProportionateScreenWidth(20),
        ),
        child: Form(
          key: formKey,
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(20)),
                Text(
                  localizations.verifyOtp,
                  style: AppStyles.headingTextStyle.copyWith(
                    fontSize: 30,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTextColor,
                  ),
                ),
                SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(8)),
                Text(
                  localizations.otpInstruction,
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.lowTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(10)),
                Text(
                  '+880 $phoneNumber',
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(32)),
                Text(
                  localizations.verificationCode,
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 15,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(otpControllers.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == otpControllers.length - 1
                            ? 0
                            : SizeConfigs.getProportionateScreenWidth(10),
                      ),
                      child: SizedBox(
                        width:
                            SizeConfigs.getProportionateScreenWidth(75),
                        height:
                            SizeConfigs.getProportionateScreenHeight(48),
                        child: TextFormField(
                          controller: otpControllers[index],
                          focusNode: otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textInputAction:
                              index == otpControllers.length - 1
                                  ? TextInputAction.done
                                  : TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          textAlign: TextAlign.center,
                          style: AppStyles.normalTextStyle.copyWith(
                            fontSize: 18,
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecorationUtils.build(
                            hintText: 'x',
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfigs
                                  .getProportionateScreenHeight(14),
                            ),
                            filled: false,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                index < otpControllers.length - 1) {
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
                SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(18)),
                Center(
                  child: resendTimer > 0
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppStyles.normalTextStyle.copyWith(
                              fontSize: 14,
                              color: AppColors.lowTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${localizations.didntReceiveCode} ',
                              ),
                              TextSpan(
                                text: localizations.resendTimerText(
                                  resendTimer,
                                ),
                                style: AppStyles.normalTextStyle.copyWith(
                                  fontSize: 14,
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      : TextButton(
                          onPressed: onResend,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            localizations.resendCode,
                            style: AppStyles.normalTextStyle.copyWith(
                              fontSize: 14,
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                ),
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(264)),
                CommonButton(
                  onPressed: onVerify,
                  text: localizations.verify,
                  height: SizeConfigs.getProportionateScreenHeight(56),
                  backgroundColor: AppColors.primaryColor,
                ),
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
