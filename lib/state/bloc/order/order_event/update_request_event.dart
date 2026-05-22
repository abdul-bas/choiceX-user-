import 'package:coice/state/bloc/order/order_event/return_request_event.dart';

class UpdateRequestEvent extends OrderBlocEvent {
  String odrderId;
  UpdateRequestEvent({required this.odrderId});
}
