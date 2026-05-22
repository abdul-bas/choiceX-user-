import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/product_helper/favorite_section/is_favorite_product.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:coice/ui/screens/product/controller/controller.dart';
import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key,
    required this.product,
    required this.value,
    required this.authBloc,
  });

  final ProductModel product;
  final int value;
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ProductController.getUserStream(),      
      builder: (context, snapshot) {
        final state = handleSnapshot(snapshot);
        if (state != null) return state;

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final bool isFavorite =
            isFavoriteProduct(data, product.id, value);

        return InkWell(                                 
          onTap: () => ProductController.toggleFavourite( 
            context: context,
            authBloc: authBloc,
            productId: product.id,
            variantIndex: value,
            currentValue: isFavorite,
          ),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFavorite
                  ? AppColors.danger.withValues(alpha: 0.3) 
                  : AppColors.onImageWhiteStrong,       
              border: Border.all(
                color: isFavorite
                    ? AppColors.danger.withValues(alpha: 0.01) 
                    : AppColors.favBorderIdle,            
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark,           
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: AppColors.danger,                  
              size: 18,
            ),
          ),
        );
      },
    );
  }
}