import 'package:alphatron/config/user_config.dart';

import '../constants/images.dart';
import '../utils/size_config.dart';
import 'loading_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Adding a delay of 4 seconds before navigating to another page
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        UserConfig.instance.init();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoadingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(splashscreen),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
