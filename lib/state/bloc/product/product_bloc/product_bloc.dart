import 'package:coice/data/repository/product_repository.dart';
import 'package:coice/state/bloc/product/poroduct_event/load_rating.dart';
import 'package:coice/state/bloc/product/poroduct_event/product_event.dart';
import 'package:coice/state/bloc/product/product_state/inital_state.dart';
import 'package:coice/state/bloc/product/product_state/load_ratig_event.dart';
import 'package:coice/state/bloc/product/product_state/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductRepository productRepository = ProductRepository();
  ProductBloc() : super(ProductInitial()) {
    on<LoadRating>((event, emit) async {
      emit(LoadRatigEventLoading());
      final resulte = await productRepository.readReview(
          productId: event.productId,
          variantIndex: event.variantIndex,
          limit: event.limit,
         );
      emit(resulte);
    });
  }
}
