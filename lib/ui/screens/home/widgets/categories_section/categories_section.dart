import 'dart:convert';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/routes/push_function.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/ui/common_widgets/ProductBrowseGrid.dart';
import 'package:coice/core/utils/handlers/product_stream_handler.dart';
import 'package:coice/ui/screens/home/controller/controller.dart';
import 'package:flutter/material.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key, required this.products});

  final List<ProductModel> products;

  void _navigateToCategory(
    BuildContext context,
    String name,
    List<ProductModel> categorized,
  ) {
    pushScreen(context, ProductBrowseGrid(products: categorized, text: name));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UiDetailsGet().categoryGet(),
      builder: (context, snapshot) {
        final widget = streamHandler(snapshot);
        if (widget != null) return widget;

        final categories = snapshot.data!.docs.toSet().toList();
        if (categories.isEmpty) return const SizedBox();

        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final category = categories[index];
              final bytes = base64Decode(category['image']);
              final categorized = HomeLogic.getProductsByCategory(
                category: category['name'],
                products: products,
              );

              return InkWell(
                onTap: () => _navigateToCategory(
                  context,
                  category['name'],
                  categorized,
                ),
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.borderLight,    
                          ),
                          color: AppColors.skeletonBase,     
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: MemoryImage(bytes),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}