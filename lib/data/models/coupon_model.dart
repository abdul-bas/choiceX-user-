class CouponModel {
  final String id;
  final String title;
  final String code;
  final double discountPercent;
  final double maxDiscount;
  final String applyType;
  final List<String> categories;
  final List<String> brands;
  final bool isActive;
  final DateTime createdAt;

  CouponModel({
    required this.id,
    required this.title,
    required this.code,
    required this.discountPercent,
    required this.maxDiscount,
    required this.applyType,
    required this.categories,
    required this.brands,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'code': code.toUpperCase(),
      'discountPercent': discountPercent,
      'maxDiscount': maxDiscount,
      'applyType': applyType.toLowerCase(),
      'categories': categories.map((e) => e.toLowerCase()).toList(),
      'brands': brands.map((e) => e.toLowerCase()).toList(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      code: map['code']?.toString().toUpperCase() ?? '',
      discountPercent:
          (map['discountPercent'] as num?)?.toDouble() ?? 0,
      maxDiscount:
          (map['maxDiscount'] as num?)?.toDouble() ?? 0,
      applyType:
          map['applyType']?.toString().toLowerCase() ?? 'all',
      categories: List<String>.from(
        (map['categories'] ?? []).map((e) => e.toString().toLowerCase()),
      ),
      brands: List<String>.from(
        (map['brands'] ?? []).map((e) => e.toString().toLowerCase()),
      ),
      isActive: map['isActive'] ?? true,
      createdAt:
          DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
