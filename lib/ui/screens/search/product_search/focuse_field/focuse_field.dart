import 'dart:convert';

import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/bloc/recent_search/recent_search_bloc.dart';
import 'package:coice/state/bloc/recent_search/recent_search_event.dart';
import 'package:coice/state/bloc/recent_search/recent_search_state.dart';
import 'package:coice/ui/screens/product/widget/section_label/build_section_label.dart';
import 'package:coice/ui/screens/search/product_search/focuse_field/widgets/acivity_list/activity_list.dart';
import 'package:coice/ui/screens/search/product_search/focuse_field/widgets/recent_searches/recent_searches.dart';
import 'package:coice/ui/screens/search/product_search/widgets/product_column_widget/product_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FocuseField extends StatelessWidget {
  const FocuseField({
    super.key,
    required this.controller,
    required this.products,
  });

  final TextEditingController controller;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    context.read<RecentSearchBloc>().add(RecentSearchGet());
    
    return BlocBuilder<RecentSearchBloc, RecentSearchState>(
      builder: (context, state) {
        List<String> searchs = [];
        List<Map<String, dynamic>> activity = [];

        if (state is RecentSearchLoaded) {
          searchs = state.searches;
          activity = state.activities;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (searchs.isNotEmpty) ...[
                buildRecentSearches(context, searchs, controller),
                const SizedBox(height: 20),
              ],
              if (activity.isNotEmpty) ...[
                buildSectionLabel('Recently Viewed'),
                const SizedBox(height: 12),
                buildActivityList(context, activity, products),
              ],
              buildSectionLabel('products'),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductColumnWidget(
                      data: product, bytes: base64Decode(product.imges[0]));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
