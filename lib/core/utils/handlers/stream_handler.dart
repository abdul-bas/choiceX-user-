import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget? sellerStreamHandler(
  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
) {
  if (snapshot.hasError) {
    return const Center(
      child: Text('Something went wrong'),
    );
  } else if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else if (!snapshot.hasData || snapshot.data!.data() == null) {
    return const Center(
      child: Text('No seller data found'),
    );
  }

  

  return null;
}
