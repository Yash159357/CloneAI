import 'package:clone_ai/view/auth/auth.dart';
import 'package:clone_ai/view/home/home_screen/home_screen.dart';
import 'package:clone_ai/view/intro_screen/intro_screen.dart';
import 'package:clone_ai/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_ai/controller/cubits/chat_cubit.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  initialExtra: {'redirect':1},
  routes: [
    GoRoute(
      path: "/splash",
      name: "splash",
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: "/auth",
      name: "auth",
      builder: (context, state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: "/intro",
      name: "intro",
      builder: (context, state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) {
        return const HomeScreen();
      },
    )
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChatCubit([]),
          ),
        ],
        child: MaterialApp.router(
          // routeInformationParser: _router.routeInformationParser,
          // routerDelegate: _router.routerDelegate,
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          routerConfig: _router,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
        ));
  }
}
