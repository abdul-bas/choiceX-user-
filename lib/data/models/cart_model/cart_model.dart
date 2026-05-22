class CartModel {
  String cartId;

  final String productId;
  final String productName;
  final String image;

  final String model;
  final String brand;
  final String color;
  final String category; 

  final double price;
  final double discountPrice;
  final double discount;

  final DateTime deliveryDate;

  final int quantity;
  final int variantIndex;

  final String userId;
  final String sellerId;
  final String status;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.image,

    required this.model,
    required this.brand,
    required this.color,
    required this.category, 

    required this.price,
    required this.discountPrice,
    required this.discount,

    required this.deliveryDate,

    required this.quantity,
    required this.variantIndex,

    required this.userId,
    required this.sellerId,
    required this.status,
  });

  /// From Firestore
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'] ?? '',
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      image: map['image'] ?? '',

      model: map['model'] ?? '',
      brand: map['brand'] ?? '',
      color: map['color'] ?? '',
      category: map['category'] ?? '', 

      price: (map['price'] ?? 0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),

      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : DateTime.now(),

      quantity: map['quantity'] ?? 1,
      variantIndex: map['variantIndex'] ?? 0,

      userId: map['userId'] ?? '',
      sellerId: map['sellerId'] ?? '',
      status: map['status'] ?? '',
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'productId': productId,
      'productName': productName,
      'image': image,

      'model': model,
      'brand': brand,
      'color': color,
      'category': category, 

      'price': price,
      'discountPrice': discountPrice,
      'discount': discount,

      'deliveryDate': deliveryDate.toIso8601String(),

      'quantity': quantity,
      'variantIndex': variantIndex,

      'userId': userId,
      'sellerId': sellerId,
      'status': status,
    };
  }

  
  double get totalPrice => discountPrice * quantity;

 
  double get savedAmount => (price - discountPrice) * quantity;

  
  String get discountLabel => "$discount% OFF";
}