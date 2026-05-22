import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/models/user_model.dart';

abstract class AuthEvent {}

class SignUp extends AuthEvent {
  UserModel model;
  SignUp({required this.model});
}

class SignIn extends AuthEvent {
  String email;
  String password;

  SignIn({required this.email, required this.password});
}

class EmailPassword extends AuthEvent {
  String email;
  EmailPassword({required this.email});
}

class Authentication extends AuthEvent {}

class AuthLogOut extends AuthEvent {}

class UpdatePassword extends AuthEvent {
  String newPassword;
  String email;
  String oldPassword;
  UpdatePassword(
      {required this.newPassword,
      required this.email,
      required this.oldPassword});
}

class GoogleSignInEvent extends AuthEvent {}

class FacebookSignInEvent extends AuthEvent {}

class AddCart extends AuthEvent {
  CartModel cart;

  AddCart({required this.cart});
}

class DeleteCart extends AuthEvent {
  String productId;
  int variantId;
  DeleteCart({required this.productId, required this.variantId});
}

class MakeandRmoveFavorite extends AuthEvent {
  String id;
  bool value;
  int variantIndex;
  MakeandRmoveFavorite(
      {required this.id, required this.value, required this.variantIndex});
}
