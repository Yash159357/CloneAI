import 'package:clone_ai/consts/color_consts.dart';
import 'package:clone_ai/consts/img_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_ai/controller/cubits/chat_cubit.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.changeWindow});

  final void Function(int index) changeWindow;

  @override
  Widget build(BuildContext context) {
    // Access the ChatCubit to get the list of ChatWindows
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final chatWindows = chatCubit.getWindows();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<void> showTitleDialog(BuildContext context) async {
      String title = ''; // Variable to hold the title

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: colSplashBg,
            title: const Text('Enter Title'),
            content: TextField(
              onChanged: (value) {
                title = value;
              },
              decoration:  InputDecoration(
                hintText: 'Title',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  if (title.isNotEmpty) {
                    chatCubit.addWindow(title);
                    context.pop();
                  }
                },
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Drawer(
      surfaceTintColor: Colors.transparent,
      backgroundColor: colSplashBg, // Dark background for the drawer
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.05),
          const Divider(color: Colors.grey, indent: 10, endIndent: 10),
          SizedBox(
            height: screenHeight * 0.09,
            width: double.infinity,
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imgLogoDark),
                  backgroundColor: Colors.transparent,
                  radius: 50,
                ),
                Text(
                  "CloneAI",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey, indent: 10, endIndent: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              height: screenHeight * 0.06,
              width: screenWidth * 0.4,
              child: ElevatedButton(
                style: ButtonStyle(
                  surfaceTintColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.black.withOpacity(0.8)),
                ),
                onPressed: () async {
                  await showTitleDialog(context);
                  changeWindow(0);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 25,
                      weight: 10,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "New Chat",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: chatWindows.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // print("Tapped on: ${chatWindows[index].title}");
                  changeWindow(index);
                  context.pop();
                  // Add your functionality here
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20, left: 16),
                  child: Text(
                    chatWindows[index].title,
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(0.9), // White text for visibility
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
