import 'package:clone_ai/model/conversation.dart';

class ChatWindow {
  ChatWindow({
    required this.conversationList,
    required this.title,
    required this.date,
  });

  final List<Conversation> conversationList;
  final String title;
  final DateTime date;

  List<Conversation> getConversationList() {
    var list = conversationList;
    list.sort(
      (a, b) {
        return b.date.compareTo(a.date);
      },
    );
    return list;
  }

  void markConversationAsAnimated(int conversationIndex) {
    if (conversationIndex >= 0 && conversationIndex < conversationList.length) {
      conversationList[conversationIndex] = Conversation(
        request: conversationList[conversationIndex].request,
        response: conversationList[conversationIndex].response,
        date: conversationList[conversationIndex].date,
        isAnimated: true,
      );
    }
  }
}
