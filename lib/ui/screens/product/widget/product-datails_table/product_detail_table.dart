// NORMAL ENUM (removed _)
import 'package:coice/core/constants/enums/spec_kind.dart';
import 'package:coice/core/utils/helpers/get_formatted_date.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/model/grop.dart';
import 'package:coice/ui/screens/product/model/spec_item.dart';
import 'package:coice/ui/screens/product/widget/product-datails_table/product_spec_card.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:flutter/material.dart';

Widget buildProductDetailsTable(int value, ProductModel product) {
  final v = product.variants[value];

  final discountPrice = afterProductDiscount(
    discount: v['discount'],
    price: v['price'],
  ).toStringAsFixed(0);

  final groups = <Group>[
    Group(
      title: 'General',
      icon: Icons.info_outline_rounded,
      items: [
        SpecItem('Product Name', product.productName),
        SpecItem('Brand', product.brand),
        SpecItem('Model', product.model),
        SpecItem('Category', product.category),
        SpecItem('Product Type', product.productType),
      ],
    ),
    Group(
      title: 'Pricing',
      icon: Icons.sell_outlined,
      items: [
        SpecItem('SKU Code', v['sku'] ?? ''),
        SpecItem('MRP', v['price'] ?? '', SpecKind.price),
        SpecItem('discount price', discountPrice, SpecKind.discount),
      ],
    ),
    Group(
      title: 'Technical',
      icon: Icons.settings_outlined,
      items: [
        SpecItem('Power', v['power'] ?? ''),
        SpecItem(
          'Connectivity',
          product.connectivityOptions.join(' · '),
        ),
        SpecItem('Warranty', product.warranty),
      ],
    ),
    Group(
      title: 'Physical',
      icon: Icons.straighten_outlined,
      items: [
        SpecItem('Weight', product.weight ?? ''),
        SpecItem('Size', product.size),
        SpecItem('Manufacture Date', getFormattedDate(product.manufactureDate)),
      ],
    ),
  ];

  return ProductSpecCard(groups: groups);
}
