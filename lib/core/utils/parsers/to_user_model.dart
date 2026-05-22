
import 'package:coice/data/models/user_model.dart';
import 'package:flutter/material.dart';

UserModel? toUserModel(AsyncSnapshot<dynamic> snapshot) {
  if (!snapshot.hasData || snapshot.data!.data() == null) return null;

  final data = snapshot.data!.data() as Map<String, dynamic>;

  
  data['address'] ??= [];

  return UserModel.fromMap(data);
}