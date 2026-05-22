

import 'package:coice/state/bloc/auth/states/auth_state.dart';



class OrdersLoadingState extends AuthState {}

class OrdersSuccessState extends AuthState {
  
  OrdersSuccessState();
}


class OrdersErrorState extends AuthState {
  final String message;

  OrdersErrorState(this.message);
}
