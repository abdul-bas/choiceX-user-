class OrderModel {
   String orderId;
  final String userId;
  final String productId;
  final String sellerId;

  final String paymentId;

  final int variantIndex;
  final int quantity;

  final double amount;

  final String productName;
  final String brand;
  final String model;
  final String color;

  final double discountPrice;
  final double discount;

  final String images;

  final String itemStatus;
  final String paymentStatus;
  final String paymentMethod;
  final String paymentAddress;

  final DateTime date;
  final DateTime expectedDate;

  final String? cancellationReason;

   OrderModel({
    required this.images,
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.sellerId,
    required this.paymentId,
    required this.variantIndex,
    required this.quantity,
    required this.amount,
    required this.productName,
    required this.brand,
    required this.model,
    required this.color,
    required this.discountPrice,
    required this.discount,
    required this.itemStatus,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.paymentAddress,
    required this.date,
    required this.expectedDate,
    this.cancellationReason,
  });

  

  OrderModel copyWith({
    String? images,
    String? orderId,
    String? userId,
    String? productId,
    String? sellerId,
    String? paymentId,
    int? variantIndex,
    int? quantity,
    double? amount,
    String? productName,
    String? brand,
    String? model,
    String? color,
    double? discountPrice,
    double? discount,
    String? itemStatus,
    String? paymentStatus,
    String? paymentMethod,
    String? paymentAddress,
    DateTime? date,
    DateTime? expectedDate,
    String? cancellationReason,
  }) {
    return OrderModel(
      images: images ?? this.images,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      paymentId: paymentId ?? this.paymentId,
      variantIndex: variantIndex ?? this.variantIndex,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      discountPrice: discountPrice ?? this.discountPrice,
      discount: discount ?? this.discount,
      itemStatus: itemStatus ?? this.itemStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentAddress: paymentAddress ?? this.paymentAddress,
      date: date ?? this.date,
      expectedDate: expectedDate ?? this.expectedDate,
      cancellationReason:
          cancellationReason ?? this.cancellationReason,
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'orderId': orderId,
      'userId': userId,
      'productId': productId,
      'sellerId': sellerId,
      'paymentId': paymentId,
      'variantIndex': variantIndex,
      'quantity': quantity,
      'amount': amount,
      'productName': productName,
      'brand': brand,
      'model': model,
      'color': color,
      'discountPrice': discountPrice,
      'discount': discount,
      'itemStatus': itemStatus,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'paymentAddress': paymentAddress,
      'date': date.toIso8601String(),
      'expectedDate': expectedDate.toIso8601String(),
      'cancellationReason': cancellationReason,
    };
  }


  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      images: map['images'] ?? '',
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      sellerId: map['sellerId'] ?? '',
      paymentId: map['paymentId'] ?? '',
      variantIndex: (map['variantIndex'] as num?)?.toInt() ?? 0,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      productName: map['productName'] ?? '',
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      color: map['color'] ?? '',
      discountPrice:
          (map['discountPrice'] as num?)?.toDouble() ?? 0.0,
      discount:
          (map['discount'] as num?)?.toDouble() ?? 0.0,
      itemStatus: map['itemStatus'] ?? 'pending',
      paymentStatus: map['paymentStatus'] ?? 'pending',
      paymentMethod: map['paymentMethod'] ?? 'unknown',
      paymentAddress: map['paymentAddress'] ?? '',
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : DateTime.now(),
      expectedDate: map['expectedDate'] != null
          ? DateTime.parse(map['expectedDate'])
          : DateTime.now().add(const Duration(days: 5)),
      cancellationReason: map['cancellationReason'],
    );
  }
}