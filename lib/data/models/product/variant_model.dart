class VariantModel {
  final String color;
  final int discount;
  final List<String> images;
  final String power;
  final double price;
  final int qty;
  final String sku;
  final String storage;

  VariantModel({
    required this.color,
    required this.discount,
    required this.images,
    required this.power,
    required this.price,
    required this.qty,
    required this.sku,
    required this.storage,
  });


  factory VariantModel.fromMap(Map<String, dynamic> map) {
    return VariantModel(
      color: map['color'] ?? '',

      discount: int.tryParse(map['discount']?.toString() ?? '') ?? 0,

      images: List<String>.from(map['images'] ?? []),

      power: map['power'] ?? '',

      price: double.tryParse(map['price']?.toString() ?? '') ?? 0.0,

      qty: int.tryParse(map['qty']?.toString() ?? '') ?? 0,

      sku: map['sku'] ?? '',

      storage: map['storage'] ?? '',
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'discount': discount.toString(),
      'images': images,
      'power': power,
      'price': price.toString(),
      'qty': qty.toString(),
      'sku': sku,
      'storage': storage,
    };
  }

  
  VariantModel copyWith({
    String? color,
    int? discount,
    List<String>? images,
    String? power,
    double? price,
    int? qty,
    String? sku,
    String? storage,
  }) {
    return VariantModel(
      color: color ?? this.color,
      discount: discount ?? this.discount,
      images: images ?? this.images,
      power: power ?? this.power,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      sku: sku ?? this.sku,
      storage: storage ?? this.storage,
    );
  }
}