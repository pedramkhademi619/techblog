import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:tech/components/my_colors.dart';
import 'package:tech/main.dart';
import '../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (mounted) {
        Get.offAndToNamed(NamedRoute.routeMainScreen);

      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: Assets.images.logo.provider(),
                height: 64,
              ),
              const SizedBox(
                height: 32,
              ),
              const SpinKitThreeBounce(
                color: SolidColors.primaryColor,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
