import 'dart:ui';

import 'package:clone_ai/consts/color_consts.dart';
import 'package:clone_ai/consts/img_consts.dart';
import 'package:clone_ai/widgets/animated_text.dart';
import 'package:clone_ai/widgets/text_field_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Image.asset(
                imgAuthBg,
                fit: BoxFit.cover,
                height: screenHeight,
                width: screenWidth,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  color: Colors.black.withOpacity(0.80),
                  height: screenHeight,
                  width: screenWidth,
                ),
              ),
              const AuthButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: AnimatedText(textSize: 60),
        ),
        SizedBox(height: screenHeight * 0.15),
        SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.06,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AuthDialog(isModeLogin: false);
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.cyan.shade700),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.06,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AuthDialog(isModeLogin: true);
                },
              );
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                side:
                    MaterialStatePropertyAll(BorderSide(color: Colors.white))),
            child: const Text(
              "Log In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.2,
        )
      ],
    );
  }
}

class AuthDialog extends StatefulWidget {
  const AuthDialog({super.key, required this.isModeLogin});

  final bool isModeLogin;

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  late bool _isLogin;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isModeLogin;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: colAuthDialog,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: screenHeight * 0.55,
        width: screenWidth * 0.975,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _isLogin ? "Log In" : "Sign Up",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 44,
                    weight: 0.5,
                  ),
                )
              ],
            ),
            // const SizedBox(height: 2),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            // **************************** Login / Sign in Fields**************
            _isLogin ? const LogInSection() : const SignUpSection(),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(color: Colors.white24),
                ),
                Text(
                  "  or  ",
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.white24),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // const Divider(color: Colors.white24),
            const IconsAuth(),
          ],
        ),
      ),
    );
  }
}

class LogInSection extends StatefulWidget {
  const LogInSection({super.key});

  @override
  LogInSectionState createState() => LogInSectionState();
}

class LogInSectionState extends State<LogInSection> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose(); // Dispose controllers when no longer needed
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          CustomTextField(
            title: "Email",
            controller: emailController,
            hint: "abc@gmail.com",
            obscure: false,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            title: "Password",
            controller: passwordController,
            hint: "abc123",
            obscure: true,
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.070,
            // decoration: const BoxDecoration(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(10),
            //   ),
            // ),
            child: ElevatedButton(
              onPressed: () {
                context.goNamed('splash', extra: {'redirecter' : 2});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.cyan.shade700),
                shape: const MaterialStatePropertyAll(
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
              child: const Text(
                "Log In  ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpSection extends StatefulWidget {
  const SignUpSection({super.key});

  @override
  SignUpSectionState createState() => SignUpSectionState();
}

class SignUpSectionState extends State<SignUpSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  final PageController _pageController =
      PageController(); // Page controller for navigation

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    _pageController.dispose(); // Dispose the page controller
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: screenHeight * 0.272,
        child: PageView(
          controller: _pageController,
          children: [
            // ***************** Page One **************************************
            Column(
              children: [
                CustomTextField(
                  title: "Name",
                  controller: nameController,
                  hint: "abc",
                  obscure: false,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "E-mail",
                  controller: emailController,
                  hint: "abc@gmail.com",
                  obscure: false,
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.070,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.cyan.shade700),
                      shape: const MaterialStatePropertyAll(
                        ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Next ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // ********************** Page 2 **********************************
            Column(
              children: [
                CustomTextField(
                  title: "Password",
                  controller: passwordController,
                  hint: "abc123",
                  obscure: true,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Confirm Password",
                  controller: cpasswordController,
                  hint: "abc123",
                  obscure: true,
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.070,
                      child: ElevatedButton(
                        onPressed: _prevPage,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade700),
                          shape: const MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Previous",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.070,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/splash', extra: {'redirecter': 2});
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.cyan.shade700),
                          shape: const MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconsAuth extends StatelessWidget {
  const IconsAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomIcon(image: imgGoogleLogo),
        CustomIcon(image: imgFacebookLogo),
        CustomIcon(image: imgGithubLogo),
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colLogoBg,
        gradient: RadialGradient(
          colors: [
            colLogoBg.withOpacity(0.95),
            colLogoBg.withOpacity(0.85),
          ],
          center: const Alignment(-0.3, -0.3),
          radius: 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(-1, -1),
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            offset: const Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
        ],
      ),
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(9),
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
