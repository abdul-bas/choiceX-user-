class ProductModel {
  String id;
  String sellerId;
  String productName;
  String brand;
  String model;
  String description;
  String category;
  String productType;
  List<String> connectivityOptions;
  String warranty;
  String? weight;
  String size;
  String tag;
  List<String> imges;
  String manufactureDate;
  String addedDate;
  String status;
  Map<String, dynamic> rating;
  List<Map<String, dynamic>> variants;
final int expectedDeliveryDays;

  ProductModel({
    required this.id,
    required this.sellerId,
    required this.productName,
    required this.brand,
    required this.model,
    required this.description,
    required this.category,
    required this.productType,
    required this.connectivityOptions,
    required this.warranty,
    this.weight,
    required this.size,
    required this.tag,
    required this.manufactureDate,
    required this.addedDate,
    required this.status,
    required this.imges,
    required this.variants,
     this.rating=const {},
      required this.expectedDeliveryDays,
  });
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'sellerId': sellerId,
    'ProductName': productName,
    'Brand': brand,
    'Model': model,
    'Description': description,
    'Category': category,
    'Type': productType,
    'ConnectivityOptions': connectivityOptions,
    'Warranty': warranty,
    'Weight': weight,
    'SizeDimensions': size,
    'TagsKeywords': tag,
    'ManufactureDate': manufactureDate,
    'AddedDate': addedDate,
    'status': status,
    'Productimages': imges,
    'rating': rating,
    'Variant': variants,
     'expectedDeliveryDays': expectedDeliveryDays,
  };
}


  factory ProductModel.fromMap(Map<String, dynamic> map, [int? variantIndex]) {
    return ProductModel(
      rating: map['rating'] is Map
    ? Map<String, dynamic>.from(map['rating'])
    : {},

      id: map['id']?.toString() ?? '',
      sellerId: map['sellerId']?.toString() ?? '',
      productName: map['ProductName']?.toString() ?? '',
      brand: map['Brand']?.toString() ?? '',
      model: map['Model']?.toString() ?? '',
      description: map['Description']?.toString() ?? '',
      category: map['Category']?.toString() ?? '',
      productType: map['Type']?.toString() ?? '',
      connectivityOptions: map['ConnectivityOptions'] is List
          ? List<String>.from(map['ConnectivityOptions'])
          : [map['ConnectivityOptions'].toString()],
      warranty: map['Warranty']?.toString() ?? '',
      weight: map['Weight']?.toString(),
      size: map['SizeDimensions']?.toString() ?? '',
      tag: map['TagsKeywords']?.toString() ?? '',
      manufactureDate: map['ManufactureDate']?.toString() ?? '',
      addedDate: map['AddedDate']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      imges: map['Productimages'] is List
          ? List<String>.from(map['Productimages'])
          : [map['Productimages'].toString()],
      variants: map['Variant'] is List
          ? List<Map<String, dynamic>>.from(map['Variant'])
          : (map['Variant'] is List
              ? List<Map<String, dynamic>>.from(map['Variant'])
              : []),
              expectedDeliveryDays: map['expectedDeliveryDays'],
              
    );
  }
}
