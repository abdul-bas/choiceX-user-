
import 'package:coice/state/bloc/order/order_event/return_request_event.dart';

class CancellationRequestEvent extends OrderBlocEvent {
  String orderId;
  String reason;
  CancellationRequestEvent({required this.orderId,required this.reason});
}
