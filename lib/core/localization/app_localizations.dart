import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App General
      'app_name': 'Free Health Camp',
      'app_tagline': 'Healing Starts Here.',
      'language': 'English',
      'or': 'or',
      
      // Auth - Login
      'welcome': 'Welcome!',
      'please_sign_in': 'Please sign in to access your account or sign up.',
      'phone_number': 'Phone number',
      'phone_hint': 'XXX XXX XXXX',
      'pin': 'PIN',
      'pin_hint': '123456',
      'forgot_pin': 'Forgot your PIN?',
      'sign_in': 'Sign In',
      'sign_up': 'Sign Up',
      'new_here': 'New here?',
      
      // Auth - Registration
      'register': 'Sign Up',
      'create_account': 'Create your account',
      'enter_phone_signup': 'Please enter your phone number to sign up.',
      'verification_code_message': "We'll send you the 4 digit verification code",
      'step_of': 'Step {{current}} of {{total}}',
      'next': 'Next',
      'previous': 'Previous',
      'submit': 'Submit',
      'already_have_account': 'Already have an account?',
      
      // Validation
      'phone_required': 'Phone number is required',
      'phone_invalid': 'Please enter a valid phone number',
      'pin_required': 'PIN is required',
      'pin_invalid': 'PIN must be 6 digits',
      'email_required': 'Email is required',
      'email_invalid': 'Please enter a valid email',
      'password_required': 'Password is required',
      'password_min_length': 'Password must be at least 6 characters',
      
      // Common
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
    },
    'bn': {
      // App General
      'app_name': 'ফ্রি হেলথ ক্যাম্প',
      'app_tagline': 'সুস্থতার শুরু এখানেই.',
      'language': 'বাংলা',
      'or': 'বা',
      
      // Auth - Login
      'welcome': 'স্বাগতম!',
      'please_sign_in': 'অনুগ্রহ করে আপনার অ্যাকাউন্ট অ্যাক্সেস করতে সাইন ইন করুন বা সাইন আপ করুন.',
      'phone_number': 'ফোন নম্বর',
      'phone_hint': 'XXX XXX XXXX',
      'pin': 'পিন',
      'pin_hint': '123456',
      'forgot_pin': 'আপনার পিন ভুলে গেছেন?',
      'sign_in': 'সাইন ইন করুন',
      'sign_up': 'সাইন আপ করুন',
      'new_here': 'নতুন এখানে?',
      
      // Auth - Registration
      'register': 'সাইন আপ করুন',
      'create_account': 'আপনার অ্যাকাউন্ট তৈরি করুন',
      'enter_phone_signup': 'সাইন আপ করতে আপনার ফোন নম্বর লিখুন।',
      'verification_code_message': 'আমরা আপনাকে ৪ সংখ্যার যাচাইকরণ কোড পাঠাবো',
      'step_of': 'ধাপ {{current}} এর {{total}}',
      'next': 'পরবর্তী',
      'previous': 'পূর্ববর্তী',
      'submit': 'জমা দিন',
      'already_have_account': 'ইতিমধ্যে একটি অ্যাকাউন্ট আছে?',
      
      // Validation
      'phone_required': 'ফোন নম্বর আবশ্যক',
      'phone_invalid': 'একটি বৈধ ফোন নম্বর লিখুন',
      'pin_required': 'পিন আবশ্যক',
      'pin_invalid': 'পিন ৬ সংখ্যার হতে হবে',
      'email_required': 'ইমেইল আবশ্যক',
      'email_invalid': 'একটি বৈধ ইমেইল লিখুন',
      'password_required': 'পাসওয়ার্ড আবশ্যক',
      'password_min_length': 'পাসওয়ার্ড কমপক্ষে ৬ অক্ষর হতে হবে',
      
      // Common
      'save': 'সংরক্ষণ',
      'cancel': 'বাতিল',
      'delete': 'মুছুন',
      'edit': 'সম্পাদনা',
      'ok': 'ঠিক আছে',
      'yes': 'হ্যাঁ',
      'no': 'না',
      'loading': 'লোড হচ্ছে...',
      'error': 'ত্রুটি',
      'success': 'সফল',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Convenience getters
  String get appName => translate('app_name');
  String get appTagline => translate('app_tagline');
  String get language => translate('language');
  String get or => translate('or');
  
  // Auth - Login
  String get welcome => translate('welcome');
  String get pleaseSignIn => translate('please_sign_in');
  String get phoneNumber => translate('phone_number');
  String get phoneHint => translate('phone_hint');
  String get pin => translate('pin');
  String get pinHint => translate('pin_hint');
  String get forgotPin => translate('forgot_pin');
  String get signIn => translate('sign_in');
  String get signUp => translate('sign_up');
  String get newHere => translate('new_here');
  
  // Auth - Registration
  String get register => translate('register');
  String get createAccount => translate('create_account');
  String get enterPhoneSignup => translate('enter_phone_signup');
  String get verificationCodeMessage => translate('verification_code_message');
  String get next => translate('next');
  String get previous => translate('previous');
  String get submit => translate('submit');
  String get alreadyHaveAccount => translate('already_have_account');
  
  String stepOf(int current, int total) {
    return translate('step_of')
        .replaceAll('{{current}}', current.toString())
        .replaceAll('{{total}}', total.toString());
  }
  
  // Validation
  String get phoneRequired => translate('phone_required');
  String get phoneInvalid => translate('phone_invalid');
  String get pinRequired => translate('pin_required');
  String get pinInvalid => translate('pin_invalid');
  String get emailRequired => translate('email_required');
  String get emailInvalid => translate('email_invalid');
  String get passwordRequired => translate('password_required');
  String get passwordMinLength => translate('password_min_length');
  
  // Common
  String get save => translate('save');
  String get cancel => translate('cancel');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get ok => translate('ok');
  String get yes => translate('yes');
  String get no => translate('no');
  String get loading => translate('loading');
  String get error => translate('error');
  String get success => translate('success');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'bn'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
