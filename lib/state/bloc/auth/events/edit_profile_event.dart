import 'package:coice/data/models/user_model.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';

class UpdateProfileEvent extends AuthEvent {
  UserModel updatedUser;

  UpdateProfileEvent(
      {required this.updatedUser});
}
