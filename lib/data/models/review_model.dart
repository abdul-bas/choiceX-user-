class ReviewDataModel {
  final String id; 
  final String userId;
  final String userName;
  final String email;      
  final double rating;
  final String review;
  final String date;
  final bool verified;

  ReviewDataModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.email,      
    required this.rating,
    required this.review,
    required this.date,
    required this.verified,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'userId': userId,
      'userName': userName,
      'email': email,     
      'rating': rating,
      'review': review,
      'date': date,
      'verified': verified,
    };
  }

  
  factory ReviewDataModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return ReviewDataModel(
      id: docId ?? map['id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',   
      rating: (map['rating'] != null)
          ? double.tryParse(map['rating'].toString()) ?? 0.0
          : 0.0,
      review: map['review'] ?? '',
      date: map['date'] ?? '',
      verified: map['verified'] ?? false,
    );
  }
}
