

import 'package:coice/state/bloc/auth/events/auth_event.dart';

class UpdatePasswordEvent extends AuthEvent {
 
  final String newPassword;
   final String oldPassword;

  UpdatePasswordEvent({ required this.newPassword,required this.oldPassword});
}
