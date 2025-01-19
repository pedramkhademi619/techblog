import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech/components/my_colors.dart';
import 'gen/assets.gen.dart';
import 'view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>  MainScreen()));
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
