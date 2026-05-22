import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget? chatStreamHandler(
AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot
) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }

  if (snapshot.hasError) {
    return const Center(child: Text('Something went wrong'));
  }

  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return const Center(child: Text('No messages yet'));
  }

  return null;
}
