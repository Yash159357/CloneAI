import 'package:clone_ai/consts/color_consts.dart';
// import 'package:clone_ai/consts/img_consts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<GlobalKey<_AnimatedContentState>> _animationKeys = 
    List.generate(4, (_) => GlobalKey<_AnimatedContentState>());

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: colSplashBg,
      pages: [
        _buildAnimatedPage(
          'Choose from countless AI models.',
          'Explore a vast selection of AI models to power your projects and innovations.',
          "assets/intro_image1.png",
          _animationKeys[0],
        ),
        _buildAnimatedPage(
          'Ignite your innovation with intelligent conversations.',
          'Spark new ideas and unlock creative solutions through engaging AI-powered dialogue.',
          "assets/intro_image2.png",
          _animationKeys[1],
        ),
        _buildAnimatedPage(
          'Customize your AI experience with Clone AI.',
          "Tailor your AI's behavior, appearance, and functionality to perfectly match your preferences.",
          "assets/intro_image3.png",
          _animationKeys[2],
        ),
        _buildAnimatedPage(
          'Your data is our priority.',
          'Protecting your data is at the heart of everything we do, from design to deployment.',
          "assets/intro_image4.png",
          _animationKeys[3],
        ),
      ],
      showDoneButton: true,
      done: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Done', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.cyan.shade700)),
          const SizedBox(width: 5),
          Icon(Icons.check, size: 22, color: Colors.cyan.shade700),
        ],
      ),
      onDone: () {
        context.go("/splash");
      },
      onSkip: () {
        context.go("/splash");
      },
      showNextButton: true,
      next: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.cyan.shade700)),
          const SizedBox(width: 5),
          Icon(Icons.arrow_forward_ios_outlined, size: 18, color: Colors.cyan.shade700),
        ],
      ),
      showBackButton: true,
      back: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.arrow_back_ios_new_outlined, size: 18, color: Colors.cyan.shade700,),
          const SizedBox(width: 5),
          Text('Back', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.cyan.shade700)),
        ],
      ),
      onChange: (index) {
        _animationKeys[index].currentState?.restartAnimation();
      },
      curve: Curves.easeInOut,
      dotsDecorator: DotsDecorator(
        color: Colors.cyan.shade700.withOpacity(0.25),
        activeColor: Colors.cyan.shade700,
      ),
    );
  }

  PageViewModel _buildAnimatedPage(String title, String body, String imagePath, GlobalKey<_AnimatedContentState> key) {
    return PageViewModel(
      titleWidget: _AnimatedContent(
        key: key,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.cyan.shade700,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      image: _AnimatedContent(
        child: Material(
          color: Colors.transparent,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 225,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
      ),
      bodyWidget: _AnimatedContent(
        child: Text(
          body,
          style: TextStyle(
            color: Colors.cyan.shade700.withOpacity(0.95),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: const PageDecoration(
        imageFlex: 5,
        bodyFlex: 2,
        imagePadding: EdgeInsets.only(bottom: 0),
        titlePadding: EdgeInsets.only(bottom: 0),
        imageAlignment: Alignment.bottomCenter,
        bodyAlignment: Alignment.topCenter,
      ),
    );
  }
}

class _AnimatedContent extends StatefulWidget {
  final Widget child;

  const _AnimatedContent({Key? key, required this.child}) : super(key: key);

  @override
  _AnimatedContentState createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<_AnimatedContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  void restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(top: _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
