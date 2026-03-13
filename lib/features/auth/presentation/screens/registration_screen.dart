import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../providers/auth_providers.dart';
import '../widgets/registration_step1_widget.dart';
import '../widgets/registration_step2_widget.dart';
import '../widgets/registration_step3_widget.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
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

  // Step 3: PIN
  final GlobalKey<FormState> _pinFormKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
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
        setState(() {
          _resendTimer--;
        });
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

  void _handleSendOTP() {
    if (_phoneFormKey.currentState!.validate()) {
      // Simulate sending OTP
      _startResendTimer();
      _nextStep();
    }
  }

  void _handleVerifyOTP() {
    final localizations = AppLocalizations.of(context)!;
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 4) {
      // Simulate OTP verification
      _nextStep();
    } else {
      SnackbarUtils.showError(context, localizations.otpIncomplete);
    }
  }

  void _handleSetPIN() {
    final localizations = AppLocalizations.of(context)!;

    if (_pinFormKey.currentState!.validate()) {
      if (_pinController.text != _confirmPinController.text) {
        SnackbarUtils.showError(context, localizations.pinsDoNotMatch);
        return;
      }

      // Register user using clean architecture
      final phoneNumber = _phoneController.text.trim();
      final pin = _pinController.text.trim();

      ref.read(authProvider.notifier).register(
            phoneNumber: phoneNumber,
            pin: pin,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs.init(context);
    final localizations = AppLocalizations.of(context)!;

    // Listen to auth state for registration completion
    ref.listen<dynamic>(authProvider, (previous, next) {
      if (next.errorMessage != null) {
        SnackbarUtils.showError(context, next.errorMessage!);
        ref.read(authProvider.notifier).clearError();
      }

      if (next.isAuthenticated) {
        // Navigate to todo screen on successful registration
        context.goNamed(AppRoute.todo.name);
      }
    });

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
              onPressed: () {
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
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          localizations.register,
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
                  SizedBox(height: SizeConfigs.getProportionateScreenHeight(8)),
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
                  RegistrationStep1Widget(
                    formKey: _phoneFormKey,
                    phoneController: _phoneController,
                    onSendOTP: _handleSendOTP,
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
                      SnackbarUtils.showInfo(
                        context,
                        localizations.otpResentSuccess,
                      );
                    },
                  ),
                  RegistrationStep3Widget(
                    formKey: _pinFormKey,
                    pinController: _pinController,
                    confirmPinController: _confirmPinController,
                    onSetPIN: _handleSetPIN,
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
