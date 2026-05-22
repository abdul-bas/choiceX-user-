import 'package:coice/state/bloc/auth/states/auth_state.dart';

class RatingLoading extends AuthState {
  RatingLoading();
}

class RatingUpdated extends AuthState {
  String message;
  RatingUpdated({required this.message});
}
