import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/search/product_search/widgets/product_column_widget/product_column_widget.dart';
import 'package:flutter/material.dart';

class OnChengedViewScreen extends StatelessWidget {
  const OnChengedViewScreen({super.key, required this.filteredList});

  final List<ProductModel> filteredList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final data = filteredList[index];
          final Uint8List bytes = base64Decode(data.imges[0]);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ProductColumnWidget(data: data, bytes: bytes),
          );
        },
      ),
    );
  }
}

