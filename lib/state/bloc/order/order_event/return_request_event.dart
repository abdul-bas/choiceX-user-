import 'package:coice/data/models/retrun_and_refund/return_and_refund.dart';

abstract class OrderBlocEvent {}


class CreateReturnRequest extends OrderBlocEvent {
  final ReturnRequestModel request;

  CreateReturnRequest({required this.request});
}


class ApproveReturnRequest extends OrderBlocEvent {
  final String requestId;

  ApproveReturnRequest({required this.requestId});
}


class RejectReturnRequest extends OrderBlocEvent {
  final String requestId;
  final String reason;

  RejectReturnRequest({
    required this.requestId,
    required this.reason,
  });
}


class CompleteReturnRequest extends OrderBlocEvent {
  final String requestId;

  CompleteReturnRequest({required this.requestId});
}


class LoadReturnRequests extends OrderBlocEvent {}


class LoadUserReturnRequests extends OrderBlocEvent {
  final String userId;

  LoadUserReturnRequests({required this.userId});
}