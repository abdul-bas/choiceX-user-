import 'package:flutter/material.dart';

Widget? handleSnapshotWithOutIndicator(AsyncSnapshot snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const SizedBox();
  }

  if (snapshot.hasError) {
    return Center(child: Text("Error: ${snapshot.error}"));
  }

  if (!snapshot.hasData) {
    return const Center(child: Text("No data found"));
  }

  return null;
}
