

import 'package:coice/data/models/chat/chat_message_model.dart';


abstract class ChatState {}
class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}
class ChatLoaded extends ChatState {
  final List<ChatMessageModel> messages;

  ChatLoaded(this.messages);
}
class ChatSending extends ChatState {}
class ChatSendSuccess extends ChatState {}
class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
class ChatMarkedAsRead extends ChatState {
  final String message;

  ChatMarkedAsRead(this.message);
}