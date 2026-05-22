class PaymentCardModel {
  final String id;
  final String userId;
  final String cardToken; 
  final String last4Digits;
  final String cardType; 
  final String cardHolderName;
  final String expiryMonth;
  final String expiryYear;
  final bool isDefault;

  PaymentCardModel({
    required this.id,
    required this.userId,
    required this.cardToken,
    required this.last4Digits,
    required this.cardType,
    required this.cardHolderName,
    required this.expiryMonth,
    required this.expiryYear,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'cardToken': cardToken,
      'last4Digits': last4Digits,
      'cardType': cardType,
      'cardHolderName': cardHolderName,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'isDefault': isDefault,
    };
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardModel(
      id: map['id'],
      userId: map['userId'],
      cardToken: map['cardToken'],
      last4Digits: map['last4Digits'],
      cardType: map['cardType'],
      cardHolderName: map['cardHolderName'],
      expiryMonth: map['expiryMonth'],
      expiryYear: map['expiryYear'],
      isDefault: map['isDefault'] ?? false,
    );
  }
}
