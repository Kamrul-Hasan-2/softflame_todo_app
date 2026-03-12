import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfigs.init(context);

    ref.listen<bool>(splashControllerProvider, (previous, next) {
      if (next) {
        context.goNamed(AppRoute.login.name);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                AppAssets.splashLogo,
                height: SizeConfigs.getProportionateScreenHeight(172),
                width: SizeConfigs.getProportionateScreenWidth(197),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
