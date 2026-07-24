
import 'package:choicex/data/models/order_model.dart';
import 'package:choicex/state/bloc/auth/events/auth_event.dart';

class PlaceOrderEvent extends AuthEvent {
  final List<OrderModel> order;

  PlaceOrderEvent({required this.order});
}
