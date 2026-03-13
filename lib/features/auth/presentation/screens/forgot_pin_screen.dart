import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../widgets/forgot_pin_step1_widget.dart';
import '../widgets/registration_step2_widget.dart';
import '../widgets/registration_step3_widget.dart';

class ForgotPinScreen extends ConsumerStatefulWidget {
  const ForgotPinScreen({super.key});

  @override
  ConsumerState<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends ConsumerState<ForgotPinScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Step 1: Phone Number
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  // Step 2: OTP
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  int _resendTimer = 50;
  Timer? _timer;

  // Step 3: New PIN
  final GlobalKey<FormState> _pinFormKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final n in _otpFocusNodes) {
      n.dispose();
    }
    _pinController.dispose();
    _confirmPinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer = 50;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _pageController.animateToPage(
          _currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      context.pop();
    }
  }

  void _handleSendOTP() {
    if (_phoneFormKey.currentState!.validate()) {
      _startResendTimer();
      _nextStep();
    }
  }

  void _handleVerifyOTP() {
    final localizations = AppLocalizations.of(context)!;
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 4) {
      _nextStep();
    } else {
      SnackbarUtils.showError(context, localizations.otpIncomplete);
    }
  }

  void _handleResetPin() {
    final localizations = AppLocalizations.of(context)!;
    if (_pinFormKey.currentState!.validate()) {
      if (_pinController.text != _confirmPinController.text) {
        SnackbarUtils.showError(context, localizations.pinsDoNotMatch);
        return;
      }
      SnackbarUtils.showSuccess(context, localizations.pinResetSuccess);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs.init(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorE0E0E0, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back,
                  color: AppColors.primaryTextColor, size: 20),
              onPressed: _prevStep,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          localizations.forgotPinTitle,
          style: AppStyles.normalTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Step Indicator
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfigs.getProportionateScreenWidth(20),
                vertical: SizeConfigs.getProportionateScreenHeight(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.stepOf(_currentStep + 1, 3),
                    style: AppStyles.normalTextStyle.copyWith(
                      fontSize: 13,
                      color: AppColors.lowTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                      height: SizeConfigs.getProportionateScreenHeight(8)),
                  Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(
                            right: index < 2
                                ? SizeConfigs.getProportionateScreenWidth(8)
                                : 0,
                          ),
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? AppColors.secondaryColor
                                : AppColors.colorE0E0E0,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Page View for Steps
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ForgotPinStep1Widget(
                    formKey: _phoneFormKey,
                    phoneController: _phoneController,
                    onNext: _handleSendOTP,
                  ),
                  RegistrationStep2Widget(
                    formKey: _otpFormKey,
                    otpControllers: _otpControllers,
                    otpFocusNodes: _otpFocusNodes,
                    phoneNumber: _phoneController.text,
                    resendTimer: _resendTimer,
                    onVerify: _handleVerifyOTP,
                    onResend: () {
                      _startResendTimer();
                    },
                  ),
                  RegistrationStep3Widget(
                    formKey: _pinFormKey,
                    pinController: _pinController,
                    confirmPinController: _confirmPinController,
                    onSetPIN: _handleResetPin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
