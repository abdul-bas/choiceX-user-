import 'package:coice/data/repository/order_repository.dart';
import 'package:coice/state/bloc/order/order_event/cancellation_request_event.dart';

import 'package:coice/state/bloc/order/order_event/return_request_event.dart';
import 'package:coice/state/bloc/order/order_event/update_request_event.dart';
import 'package:coice/state/bloc/order/order_state/return_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderBlocEvent, OrderBlocState> {
  OrderRepository orderRepository = OrderRepository();
  OrderBloc() : super(OrderBlocInitial()) {
    on<CreateReturnRequest>((event, emit) async {
      emit(ReturnRequestLoading());
      final state = await orderRepository.createReturnRequest(event.request);
      emit(state);
    });
     on<UpdateRequestEvent>((event, emit) async {
      emit(ReturnRequestLoading());
      final state = await orderRepository.updateRequest(event.odrderId);
      emit(state);
    });
    on<CancellationRequestEvent>((event, emit) async {
      emit(ReturnRequestLoading());
      final state = await orderRepository.cancelOrder(event.orderId,event.reason);
      emit(state);
    });
  }
  
}
