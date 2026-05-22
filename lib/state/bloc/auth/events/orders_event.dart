import 'package:coice/data/models/order_model.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';

class PlaceOrderEvent extends AuthEvent {
  final List<OrderModel> order;

  PlaceOrderEvent({required this.order});
}
