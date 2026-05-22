import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/ui/screens/home/barand/barand.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:coice/ui/screens/home/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedBanner extends StatelessWidget {
  FeaturedBanner({super.key, required this.products});

  final List<ProductModel> products;
  final ValueNotifier<int> activeIndex = ValueNotifier(0);

  void _navigateToBrand(BuildContext context, dynamic brand) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BrandDetailScreen(
          products: products,
          brandName: brand['name'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UiDetailsGet().getBrand(),
      builder: (context, asyncSnapshot) {
        final result = handleSnapshot(asyncSnapshot);
        if (result != null) return result;

        final brands = asyncSnapshot.data!.docs;
        if (brands.isEmpty) return const SizedBox();

        final count = HomeLogic.getBrandCount(brands);

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: count,
              itemBuilder: (context, index, realIndex) {
                final brand = brands[index];
                final bytes = base64Decode(brand['image']);

                return GestureDetector(
                  onTap: () => _navigateToBrand(context, brand),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: MemoryImage(bytes),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.98,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                onPageChanged: (index, _) => activeIndex.value = index,
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: activeIndex,
              builder: (context, value, _) {
                return AnimatedSmoothIndicator(
                  activeIndex: value,
                  count: count,
                  effect: WormEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    spacing: 10,
                    dotColor: AppColors.textMuted,   
                    activeDotColor: AppColors.brand,  
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}