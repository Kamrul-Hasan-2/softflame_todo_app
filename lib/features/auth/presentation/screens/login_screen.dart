import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_health_camp/core/utils/app_assets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_providers.dart';
import '../widgets/common_button.dart';
import '../widgets/common_text_field.dart';
import '../widgets/language_toggle_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isPinVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfigs.init(context);
    final localizations = AppLocalizations.of(context)!;
    
    // Listen to auth state changes
    ref.listen<dynamic>(authProvider, (previous, next) {
      if (next.errorMessage != null) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.colorF14F4A,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
      
      if (next.isAuthenticated) {
        // Navigate to todo screen on successful login
        context.goNamed(AppRoute.todo.name);
      }
    });
    
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfigs.getProportionateScreenWidth(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // Language Toggle Button
                const Align(
                  alignment: Alignment.centerRight,
                  child: LanguageToggleButton(),
                ),
                

                
                // Logo with text
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppAssets.splashLogo,
                        height: SizeConfigs.getProportionateScreenHeight(106),
                        width: SizeConfigs.getProportionateScreenWidth(156),
                      ),
                      //SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),
                      // Text(
                      //   'FREE HEALTH CARE',
                      //   style: AppStyles.normalTextStyle.copyWith(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w700,
                      //     color: AppColors.primaryTextColor,
                      //     letterSpacing: 0.5,
                      //   ),
                      // ),
                      // Text(
                      //   'By AllTrianz Private Limited',
                      //   style: AppStyles.normalTextStyle.copyWith(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w400,
                      //     color: AppColors.lowTextColor,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),
                
                // Tagline
                Center(
                  child: Text(
                    localizations.appTagline,
                    style: AppStyles.headingTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),
                
                // Welcome back title
                Text(
                  localizations.welcome,
                  style: AppStyles.headingTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTextColor,
                  ),
                ),
                
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(8)),
                
                // Subtitle
                Text(
                  localizations.pleaseSignIn,
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),
                
                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        controller: _phoneController,
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
                              SizedBox(width: SizeConfigs.getProportionateScreenWidth(8)),
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
                      
                      // PIN Label
                      Text(
                        localizations.pin,
                        style: AppStyles.normalTextStyle.copyWith(
                          fontSize: 16,
                          color: AppColors.color0D2238,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: SizeConfigs.getProportionateScreenHeight(8)),
                      
                      // PIN Input
                      CommonTextField(
                        controller: _pinController,
                        hintText: localizations.pinHint,
                        keyboardType: TextInputType.number,
                        obscureText: !_isPinVisible,
                        validator: (value) => Validators.validatePin(value, length: 6),
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
                      
                      SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),
                      
                      // Forgot PIN?
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot PIN
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            localizations.forgotPin,
                            style: AppStyles.normalTextStyle.copyWith(
                              fontSize: 14,
                              color: AppColors.color0D2238,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),
                      
                      // Sign In Button
                      CommonButton(
                        onPressed: authState.isLoading ? null : _handleSignIn,
                        text: authState.isLoading ? localizations.loading : localizations.signIn,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      
                      SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),
                      
                      // Or divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.colorE0E0E0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              localizations.or,
                              style: AppStyles.normalTextStyle.copyWith(
                                fontSize: 13,
                                color: AppColors.color888E9D,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.colorE0E0E0,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: SizeConfigs.getProportionateScreenHeight(24)),
                      
                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            context.pushNamed(AppRoute.registration.name);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.colorE0E0E0,
                              width: 1,
                            ),
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primaryTextColor,
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfigs.getProportionateScreenHeight(14),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            localizations.signUp,
                            style: AppStyles.normalTextStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: SizeConfigs.getProportionateScreenHeight(32)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      // Use auth provider to login
      final phoneNumber = _phoneController.text.trim();
      final pin = _pinController.text.trim();
      
      ref.read(authProvider.notifier).login(
        phoneNumber: phoneNumber,
        pin: pin,
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
