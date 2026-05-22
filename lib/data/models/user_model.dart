

import 'dart:io';

class UserModel {
  String name;
  String email;
  String? uid;
  String password;
  String? fcmToken;
  File? image;
  DateTime createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.uid,
    this.fcmToken,
    this.image,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'password': password,
      'fcmToken': fcmToken,

     
      'image': image?.path,

      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'],
      password: map['password'] ?? '',
      fcmToken: map['fcmToken'],

      
      image: map['image'] != null
          ? File(map['image'])
          : null,

      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}