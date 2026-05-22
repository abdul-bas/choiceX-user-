import 'package:coice/ui/screens/product/model/grop.dart';
import 'package:coice/ui/screens/product/widget/product-datails_table/group_section.dart';
import 'package:flutter/material.dart';

class ProductSpecCard extends StatelessWidget {
  const ProductSpecCard({super.key, required this.groups});

  final List<Group> groups;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        groups.length,
        (i) => GroupSection(
          group: groups[i],
          isLast: i == groups.length - 1,
        ),
      ),
    );
  }
}
