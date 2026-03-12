import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  bool build() {
    _navigateToNextScreen();
    return false;
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    state = true;
  }
}
