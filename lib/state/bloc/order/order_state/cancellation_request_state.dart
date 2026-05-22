import 'package:coice/state/bloc/order/order_state/return_request_state.dart';

class CancellationRequestSuccess extends OrderBlocState {
  final String message;

  CancellationRequestSuccess(this.message);
}

class CancellationRequestStateFailure extends OrderBlocState {
  final String error;

  CancellationRequestStateFailure(this.error);
}