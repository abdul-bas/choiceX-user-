
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/background_circle.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/favourite_button.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/image_carousel.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class  ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
    required this.indcatorIndex,
    required this.value,
  });

  final ProductModel product;
  final ValueNotifier<int> indcatorIndex;
  final int value;

  @override
  Widget build(BuildContext context) {
    final images = product.variants[value]['images'] as List;
    final authBloc = context.read<AuthBloc>();

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        
        BackgroundCircle(top: -40, right: -40, size: 180),
        BackgroundCircle(bottom: 0, left: -20, size: 140),

    
        ImageCarousel(images: images, indcatorIndex: indcatorIndex),

      
        Positioned(
          bottom: 36,
          right: 24,
          child: FavouriteButton(
            product: product,
            value: value,
            authBloc: authBloc,
          ),
        ),

     
        Positioned(
          bottom: 14,
          child: PageIndicator(
            indcatorIndex: indcatorIndex,
            count: images.length,
          ),
        ),
      ],
    );
  }
}







