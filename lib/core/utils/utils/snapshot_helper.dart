
import 'package:flutter/material.dart';

Widget? handleSnapshot(AsyncSnapshot snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }

  if (snapshot.hasError) {
    return Center(child: Text("Error: ${snapshot.error}"));
  }

  if (!snapshot.hasData) {
    return const Center(child: Text("No data found"));
  }

  return null;
}

