import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_items/date_label.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_items/formate_date_lable.dart';

List<dynamic> buildMessageItems(List<ChatMessageModel> messages) {
  if (messages.isEmpty) return [];
  final items = <dynamic>[];
  DateTime? lastDate;

  for (final msg in messages) {
    final d = msg.createdAt;
    final msgDate = DateTime(d.year, d.month, d.day);

    if (lastDate == null || msgDate != lastDate) {
      items.add(DateLabel(formatDateLabel(msgDate)));
      lastDate = msgDate;
    }
    items.add(msg);
  }
  return items;
}