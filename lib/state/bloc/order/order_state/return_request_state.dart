

abstract class OrderBlocState {}

class OrderBlocInitial extends OrderBlocState {}

class ReturnRequestLoading extends OrderBlocState {}

class ReturnRequestSuccess extends OrderBlocState {
  final String message;

  ReturnRequestSuccess(this.message);
}

class ReturnRequestFailure extends OrderBlocState {
  final String error;

  ReturnRequestFailure(this.error);
}

