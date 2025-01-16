import 'package:clone_ai/consts/color_consts.dart';
import 'package:clone_ai/controller/cubits/chat_cubit.dart';
import 'package:clone_ai/model/conversation.dart';
import 'package:clone_ai/services/chatgpt.dart';
import 'package:clone_ai/services/gemini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_ai/consts/img_consts.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.selectedIndex});
  final int selectedIndex;
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;
  String _selectedService = 'Gemini'; // Default service
  final Map<String, Function(String)> _serviceMap = {
    'Gemini': getGeminiResponse,
    'ChatGPT': getChatGPTResponse,
  };
  final Map<String, String> _serviceImgMap = {
    'Gemini': imgGeminiLogo,
    'ChatGPT': imgChatGPTLogo,
  };

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isExpanded = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var chatCubit = BlocProvider.of<ChatCubit>(context);

    return BottomAppBar(
      height: 120,
      color: colSplashBg,
      surfaceTintColor: Colors.transparent,
      child: Container(
        decoration: _isExpanded
            ? const BoxDecoration()
            : const BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isExpanded) // Show dropdown only when not expanded
              Container(
                margin: const EdgeInsets.only(right: 6),
                width: 60,
                height: 55,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: _selectedService,
                    underline: const SizedBox(),
                    alignment: AlignmentDirectional.center,
                    // isExpanded: true,
                    selectedItemBuilder: (context) {
                      return [
                        Center(
                          child: Image.asset(
                            imgGeminiLogo,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            imgChatGPTLogo,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ];
                    },
                    icon: const SizedBox(),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Gemini',
                        child: Center(
                          child: Image.asset(
                            imgGeminiLogo,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'ChatGPT',
                        child: Center(
                          child: Image.asset(
                            imgChatGPTLogo,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedService = newValue!;
                      });
                    },
                  ),
                ),
              ),
            Flexible(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? 110 : 55,
                decoration: BoxDecoration(
                  color: colSplashBg,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(_isExpanded ? 20 : 30),
                ),
                child: TextField(
                  keyboardAppearance: Brightness.dark,
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: 10,
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    filled: false,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.cyan),
              onPressed: () async {
                // Anonymous function to handle send action
                String message = _controller.text;
                if (message.isNotEmpty) {
                  // print(response);
                  var convo = Conversation(
                    request: message,
                    response: "",
                    date: DateTime.now(),
                    isAnimated: false,
                  );
                  chatCubit.addConversation(convo, widget.selectedIndex);
                  _controller.clear();
                  _focusNode.unfocus();
                  setState(() {
                    _isExpanded = false;
                  });
                  try {
                    // Use the selected service to get the response
                    var response =
                        await _serviceMap[_selectedService]!(message);
                    chatCubit.removeDullConversation(
                        widget.selectedIndex); // Remove the dull conversation
                    chatCubit.addConversation(
                      Conversation(
                        request: message,
                        response: response,
                        date: DateTime.now(),
                        isAnimated: false,
                      ),
                      widget.selectedIndex,
                    );
                  } catch (e) {
                    print('Error: $e'); // Handle any errors
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
