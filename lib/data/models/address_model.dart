class AddressModel {
   String id;
  final String fullAddress;
   bool isDefault;
  final String location;
  final String nickName;
  final String phoneNumber;

  AddressModel({
    required this.id,
    required this.fullAddress,
    required this.isDefault,
    required this.location,
    required this.nickName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'FullAddress': fullAddress,
      'IsDefault': isDefault,
      'Location': location,
      'NickName': nickName,
      'phoneNumber': phoneNumber,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id']??'',
      fullAddress: map['FullAddress'] ?? '',
      isDefault: map['IsDefault'] ?? false,
      location: map['Location'] ?? '',
      nickName: map['NickName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
