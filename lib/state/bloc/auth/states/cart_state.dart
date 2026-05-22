import 'package:coice/state/bloc/auth/states/auth_state.dart';

class CartSuccessfullyAdded extends AuthState {
  final String message;
  final String productName;

  final String price;

  final DateTime addedTime;

  CartSuccessfullyAdded({
    required this.message,
    required this.productName,
    required this.price,
    required this.addedTime,
  });
}

class CartLoading extends AuthState {}

class CartsuccessfullyDeleted extends AuthState {
  String productId;
  String variantIndex;
  CartsuccessfullyDeleted({required this.productId,required this.variantIndex});
}
