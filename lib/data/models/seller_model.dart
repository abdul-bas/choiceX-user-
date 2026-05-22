import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel {
  final String email;
  final String ownerName;
  final String businessType;
  final String dateOfBirth;
  final String regPhoneNumber;
  final String street;
  final String phoneNumber;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String landMark;
  final String userName;
  final String password;
  final String status;
  final String? uid;

  SellerModel({
    required this.email,
    required this.ownerName,
    required this.businessType,
    required this.dateOfBirth,
    required this.regPhoneNumber,
    required this.street,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.landMark,
    required this.userName,
    required this.password,
    required this.status,
    this.uid
  });

  Map<String, dynamic> toMap(SellerModel model) {
    return {
      'email': model.email,
      'ownerName': model.ownerName,
      'businessType': model.businessType,
      'dateOfBirth': model.dateOfBirth,
      'regPhoneNumber': model.regPhoneNumber,
      'street': model.street,
      'phoneNumber': model.phoneNumber,
      'city': model.city,
      'state': model.state,
      'country': model.country,
      'zipCode': model.zipCode,
      'landMark': model.landMark,
      'userName': model.userName,
      'password': model.password,
      'status': model.status,
      'createdAt': FieldValue.serverTimestamp(),
      'uid':model.uid
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      email: map['email'] ?? '',
      ownerName: map['ownerName'] ?? '',
      businessType: map['businessType'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      regPhoneNumber: map['regPhoneNumber'] ?? '',
      street: map['street'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      zipCode: map['zipCode'] ?? '',
      landMark: map['landMark'] ?? '',
      userName: map['userName'] ?? '',
      password: map['password'] ?? '',
      status: map['status'] ?? 'pending',
      uid: map['uid']
    );
  }
}
