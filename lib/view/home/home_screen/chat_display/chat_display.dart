import 'package:clone_ai/consts/color_consts.dart';
import 'package:clone_ai/consts/img_consts.dart';
import 'package:clone_ai/model/chat_window.dart';
// import 'package:clone_ai/widgets/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatDisplay extends StatelessWidget {
  const ChatDisplay({super.key, required this.chatWindow});

  final ChatWindow chatWindow;
  @override
  Widget build(BuildContext context) {
    var conversationList = chatWindow.getConversationList();
    var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        shrinkWrap: true,
        itemCount: conversationList.length,
        itemBuilder: (context, index) {
          var requestBox = Container(
            width: screenWidth * 0.6,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
              color: colRequestBox,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              conversationList[index].request,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          );

          Widget choiseResponseText = conversationList[index].isAnimated
              ? Text(
                  conversationList[index].response,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              : AnimatedTextKit(
                  isRepeatingAnimation: false,
                  onFinished: () {
                    chatWindow.markConversationAsAnimated(index);
                  },
                  animatedTexts: [
                    TyperAnimatedText(
                      conversationList[index].response,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );

          var responseBox = Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 16),
            child: conversationList[index].response == ""
                ? const CircleAvatar(
                    backgroundImage: AssetImage(imgLoadingAnimation),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  )
                : choiseResponseText,
          );

          return Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  requestBox,
                ],
              ),
              responseBox,
            ],
          );
        },
      ),
    );
  }
}
