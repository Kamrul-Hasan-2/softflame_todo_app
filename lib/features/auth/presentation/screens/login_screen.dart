import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_health_camp/core/utils/app_styles.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/common_button.dart';
import '../widgets/common_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _isChecked = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfigs.init(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              SizeConfigs.getProportionateScreenWidth(10),
              SizeConfigs.getProportionateScreenHeight(50),
              SizeConfigs.getProportionateScreenHeight(10),
              0,
            ),
            child: Text(
              "Sign in to your account 👋",
              style: AppStyles.titleTextStyle,
            ),
          ),
          SizedBox(
            height: SizeConfigs.getProportionateScreenHeight(20),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CommonTextField(
                    controller: _emailTEController,
                    hintText: "Enter your Email",
                    prefixIcon: const Icon(Icons.email),
                    validator: Validators.validateEmail,
                  ),
                  SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(10),
                  ),
                  CommonTextField(
                    keyboardType: TextInputType.text,
                    obscureText: !_isPasswordVisible,
                    controller: _passwordTEController,
                    hintText: "Enter your Password",
                    prefixIcon: const Icon(Icons.lock),
                    validator: Validators.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(10),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {});
                          _isChecked = value!;
                        },
                      ),
                      Text(
                        "I agree with policy and terms",
                        style: AppStyles.normalTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfigs.getProportionateScreenHeight(10),
                  ),
                  CommonButton(
                    onPressed: _handleSignIn,
                    text: 'Sign In',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      print('Form is valid');
      print('Email: ${_emailTEController.text}');
      print('Password: ${_passwordTEController.text}');
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
