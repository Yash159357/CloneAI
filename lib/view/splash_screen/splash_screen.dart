import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clone_ai/consts/color_consts.dart';
import 'package:clone_ai/consts/img_consts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final redirecter = GoRouterState.of(context).extra! as Map<String, int>;

        if (redirecter['redirecter'] == 2) {
          context.goNamed("home");
        } else {
          context.goNamed("auth");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colSplashBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 64,
                fontFamily: 'Horizon',
                color: Colors.cyan.shade700,
              ),
              child: AnimatedTextKit(
                totalRepeatCount: 9999,
                pause: const Duration(milliseconds: 500),
                animatedTexts: [
                  RotateAnimatedText("Welcome to"),
                  RotateAnimatedText("CloneAI"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 225),
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imgLoadingAnimation),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 75),
        ],
      ),
    );
  }
}
