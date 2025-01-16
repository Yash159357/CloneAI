class Conversation {
  const Conversation({
    required this.request,
    required this.response,
    required this.date,
    required this.isAnimated,
  });

  final String request;
  final String response;
  final DateTime date;
  final bool isAnimated;
}
