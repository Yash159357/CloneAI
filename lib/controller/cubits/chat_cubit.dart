import 'package:clone_ai/model/chat_window.dart';
import 'package:clone_ai/model/conversation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Conversation> demoConvoList = [
  Conversation(
    request: "What is an apple? 1",
    response:
        "An apple is a sweet, edible fruit produced by an apple tree. It is a pome fruit, meaning it has a fleshy core surrounded by five carpels. Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus.",
    date: DateTime.parse("2025-01-10 12:15:15"),
    isAnimated: true,
  ),
  Conversation(
    request: "What is an apple? 3",
    response:
        "An apple is a sweet, edible fruit produced by an apple tree. It is a pome fruit, meaning it has a fleshy core surrounded by five carpels. Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus.",
    date: DateTime.parse("2025-01-10 12:15:42"),
    isAnimated: true,
  ),
  Conversation(
    request: "What is an apple? 2",
    response:
        "An apple is a sweet, edible fruit produced by an apple tree. It is a pome fruit, meaning it has a fleshy core surrounded by five carpels. Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus.",
    date: DateTime.parse("2025-01-10 12:15:30"),
    isAnimated: true,
  ),
];
List<ChatWindow> demoData = [
  ChatWindow(
    conversationList: demoConvoList,
    title: "Title 1",
    date: DateTime.now(),
  ),
  ChatWindow(
    conversationList: demoConvoList,
    title: "Title 2",
    date: DateTime.now(),
  ),
  ChatWindow(
    conversationList: demoConvoList,
    title: "Title 3",
    date: DateTime.now(),
  ),
];

class ChatCubit extends Cubit<List<ChatWindow>> {
  ChatCubit(List<ChatWindow> chatWindows) : super(demoData);

  int size() {
    return state.length;
  }

  void addWindow(String title) {
    ChatWindow newWin =
        ChatWindow(conversationList: [], title: title, date: DateTime.now());
    emit([newWin, ...state]);
  }

  void addConversation(Conversation convo, int index) {
    if (index >= 0 && index < state.length) {
      List<ChatWindow> updatedWindows = List.from(state);

      updatedWindows[index] = ChatWindow(
        conversationList: [...updatedWindows[index].conversationList, convo],
        title: updatedWindows[index].title,
        date: updatedWindows[index].date,
      );

      emit(updatedWindows);
    }
  }

  void removeDullConversation(int index) {
    if (index >= 0 && index < state.length) {
      List<ChatWindow> updatedWindows = List.from(state);
      updatedWindows[index] = ChatWindow(
        conversationList: updatedWindows[index]
            .conversationList
            .where((convo) => convo.response.isNotEmpty)
            .toList(),
        title: updatedWindows[index].title,
        date: updatedWindows[index].date,
      );
      emit(updatedWindows);
    }
  }

  ChatWindow getWindow(int index) {
    return state[index];
  }

  List<ChatWindow> getWindows() {
    return state;
  }
}
