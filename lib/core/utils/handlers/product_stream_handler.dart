import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

dynamic streamHandler(
  AsyncSnapshot<QuerySnapshot> snapshot,
) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }

  if (snapshot.hasError) {
    return const Center(child: Text('Something went wrong'));
  }

 

  return null;
}
