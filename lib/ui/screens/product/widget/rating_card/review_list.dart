import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/review_model.dart';
import 'package:coice/state/bloc/product/product_bloc/product_bloc.dart';
import 'package:coice/ui/screens/product/widget/rating_card/build_review_item.dart';
import 'package:coice/ui/screens/product/widget/rating_card/load_more_overlay.dart';
import 'package:flutter/material.dart';

Widget buildReviewList(
  List<Map<String, dynamic>> reviews,
  bool isEnd,
  ProductBloc bloc,
  String productId,
  int variantIndex,
  BuildContext context,
) {
  if (reviews.isEmpty) return const SizedBox.shrink();

  return Stack(
    children: [
      Column(
        children: List.generate(reviews.length, (i) {
          final model = ReviewDataModel.fromMap(reviews[i]);
          return Column(
            children: [
              buildReviewItem(model),
              if (i < reviews.length - 1)
                Divider(
                  color: AppColors.grey100,              
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  height: 0,
                ),
            ],
          );
        }),
      ),
      if (!isEnd)
        buildLoadMoreOverlay(bloc, productId, variantIndex, context),
    ],
  );
}