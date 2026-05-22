import 'package:carousel_slider/carousel_slider.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/image_tile.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    super.key,
    required this.images,
    required this.indcatorIndex,
  });

  final List images;
  final ValueNotifier<int> indcatorIndex;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map<Widget>((e) => ImageTile(raw: e)).toList(),
      options: CarouselOptions(
        height: 400,
        viewportFraction: 0.934,
        autoPlay: images.length > 1,
        aspectRatio: 30 / 9,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayCurve: Curves.easeInOutCubic,
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        onPageChanged: (index, _) => indcatorIndex.value = index,
      ),
    );
  }
}
