import 'package:clone_ai/consts/color_consts.dart';
import 'package:clone_ai/controller/cubits/chat_cubit.dart';
import 'package:clone_ai/model/chat_window.dart';
import 'package:clone_ai/view/home/bottom_bar.dart/bottom_bar.dart';
import 'package:clone_ai/view/home/drawer/main_drawer.dart';
import 'package:clone_ai/view/home/home_screen/chat_display/chat_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedWindow = 0;
  void _changeWindow(int index) {
    setState(() {
      selectedWindow = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var chatCubit = BlocProvider.of<ChatCubit>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "CloneAI",
          style: TextStyle(
            fontSize: 42,
            color: Colors.cyan,
            fontFamily: 'Horizon',
            fontWeight: FontWeight.w400,
          ),
        ),
        toolbarHeight: screenHeight * 0.08,
        surfaceTintColor: Colors.transparent,
        backgroundColor: colSplashBg,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.cyan,
                size: 48,
              ),
            );
          },
        ),
      ),
      backgroundColor: colSplashBg,
      // ****************************** Drawer ********************************
      drawer: MainDrawer(changeWindow: _changeWindow),
      body: SafeArea(
        child: Column(
          children: [
            // ************************ Main Chat Display *********************
            Expanded(
              child: BlocBuilder<ChatCubit, List<ChatWindow>>(
                builder: (context, chatWindows) {
                  // print("rebuilded***************************************");
                  return ChatDisplay(chatWindow: chatCubit.getWindow(selectedWindow));
                },
              ),
            ),
            // ************************ Bottom Bar ****************************
            BottomBar(selectedIndex: selectedWindow),
          ],
        ),
      ),
    );
  }
}
