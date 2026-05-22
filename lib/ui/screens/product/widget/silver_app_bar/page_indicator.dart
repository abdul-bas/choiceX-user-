import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.indcatorIndex,
    required this.count,
  });

  final ValueNotifier<int> indcatorIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return ValueListenableBuilder<int>(
      valueListenable: indcatorIndex,
      builder: (context, index, _) {
        return AnimatedSmoothIndicator(
          activeIndex: index,
          count: count,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            radius: 4,
            spacing: 6,
            expansionFactor: 3.5,
            activeDotColor: AppColors.brand,         
            dotColor: AppColors.brandSubtle,           
          ),
        );
      },
    );
  }
}
