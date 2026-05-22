
import 'package:coice/state/bloc/product/product_state/product_state.dart';

class LoadRatigEventSuccessfully extends ProductBlocState {
  List<Map<String, dynamic>> ratings;
  bool isEnd;
  LoadRatigEventSuccessfully({required this.ratings,required this.isEnd});
}

class LoadRatigEventError extends ProductBlocState {
  String message;
  LoadRatigEventError({required this.message});
}

class LoadRatigEventLoading extends ProductBlocState {}
