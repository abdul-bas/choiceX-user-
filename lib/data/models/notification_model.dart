class NotificationModel {
  
  final String title;
  final String body;
  final String type; 
  final String? orderId; 
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    
    required this.title,
    required this.body,
    required this.type,
    this.orderId,
    required this.isRead,
    required this.createdAt,
  });

  
  factory NotificationModel.fromMap(
    Map<String, dynamic> map,
    
  ) {
    return NotificationModel(
      
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      type: map['type'] ?? '',
      orderId: map['orderId'],
      isRead: map['isRead'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['timestamp'] ?? 0,
      ),
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'orderId': orderId,
      'isRead': isRead,
      'timestamp': createdAt.millisecondsSinceEpoch,
    };
  }
}
