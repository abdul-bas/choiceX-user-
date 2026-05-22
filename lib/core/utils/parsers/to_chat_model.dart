import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/chat/chat_message_model.dart';



List<ChatMessageModel> toChatModel(List<QueryDocumentSnapshot<Map<String, dynamic>>>  docs) {
  final messages = docs.map((e) {
    return ChatMessageModel.fromMap(e.data() );
  }).toList();

  messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

  return messages;
}

