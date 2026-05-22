import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/calculate_avg_rating.dart';
import 'package:coice/core/utils/helpers/calculate_rating_reakdown.dart';
import 'package:coice/core/utils/helpers/get_total_reviews.dart';
import 'package:coice/state/bloc/product/poroduct_event/load_rating.dart';
import 'package:coice/state/bloc/product/product_bloc/product_bloc.dart';
import 'package:coice/state/bloc/product/product_state/load_ratig_event.dart';
import 'package:coice/state/bloc/product/product_state/product_state.dart';
import 'package:coice/ui/screens/product/controller/controller.dart';
import 'package:coice/core/utils/utils/snapshot_handler_without_indicator.dart';
import 'package:coice/ui/screens/product/widget/rating_card/no_reviews_state.dart';
import 'package:coice/ui/screens/product/widget/rating_card/review_list.dart';
import 'package:coice/ui/screens/product/widget/rating_card/section_header.dart';
import 'package:coice/ui/screens/product/widget/rating_card/summery_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingCardWidget extends StatefulWidget {
  const RatingCardWidget({
    super.key,
    required this.productId,
    required this.variantindex,
    this.onSeeAllReviews,
    this.onWriteReview,
  });

  final String productId;
  final int variantindex;
  final VoidCallback? onSeeAllReviews;
  final VoidCallback? onWriteReview;

  @override
  State<RatingCardWidget> createState() => _RatingCardWidgetState();
}

class _RatingCardWidgetState extends State<RatingCardWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
          LoadRating(
            productId: widget.productId,
            variantIndex: widget.variantindex,
            limit: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductBloc>();

    return BlocBuilder<ProductBloc, ProductBlocState>(
      buildWhen: (_, current) => current is LoadRatigEventSuccessfully,
      builder: (context, state) {
        final List<Map<String, dynamic>> loadMore =
            state is LoadRatigEventSuccessfully ? state.ratings : [];
        final bool isEnd =
            state is LoadRatigEventSuccessfully ? state.isEnd : false;

        return FutureBuilder(
          future: ProductController.readReviews(        
            productId: widget.productId,
            variantIndex: widget.variantindex,
          ),
          builder: (context, snapshot) {
            final errorWidget =
                handleSnapshotWithOutIndicator(snapshot);
            if (errorWidget != null) return errorWidget;

            final reviews = ProductController.convertReviews(snapshot.data);
            final avg = calculateAverageRating(reviews);
            final total = getTotalReviews(reviews);
            final breakdown = calculateRatingBreakdown(reviews);

          
            if (total == 0) {
              return const NoReviewsState();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ratings & Reviews',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grey800,           
                  ),
                ),
                const SizedBox(height: 14),
                buildSummaryCard(avg, total, breakdown),
                Divider(
                  color: AppColors.grey100,              
                  thickness: 1,
                  height: 28,
                ),
                buildReviewHeader(widget.onWriteReview),
                const SizedBox(height: 14),
                buildReviewList(loadMore, isEnd, bloc,
                    widget.productId, widget.variantindex, context),
              ],
            );
          },
        );
      },
    );
  }
}