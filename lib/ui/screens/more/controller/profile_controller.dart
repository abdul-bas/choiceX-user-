
import 'package:choicex/core/routes/push_function.dart';
import 'package:choicex/core/utils/parsers/to_user_model.dart';
import 'package:choicex/data/models/user_model.dart';
import 'package:choicex/data/repository/auth_repository.dart';
import 'package:choicex/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:choicex/state/bloc/auth/events/auth_event.dart';
import 'package:choicex/state/bloc/auth/events/update_password_event.dart';
import 'package:choicex/ui/screens/account/edit_profile.dart';
import 'package:choicex/ui/screens/cart/my_cart.dart';
import 'package:choicex/ui/screens/more/notifications/notifications.dart';
import 'package:choicex/ui/screens/more/saved_items/saved_items.dart';
import 'package:choicex/ui/screens/more/update_password/update_password.dart';
import 'package:choicex/ui/screens/order/my_orders.dart';
import 'package:choicex/ui/screens/user_address/manage_user_address/address_mgt.dart';
import 'package:choicex/ui/screens/welcom_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileController {
  ProfileController._();

  static Stream<dynamic> getUserStream() => AuthRepository().userData();

  static UserModel? parseUser(AsyncSnapshot<dynamic> snapshot) => toUserModel(snapshot);

  static void updatePassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
  }) {
    context.read<AuthBloc>().add(
          UpdatePasswordEvent(
            newPassword: newPassword,
            oldPassword: currentPassword,
          ),
        );
  }

  static String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    }
    return null;
  }

  static String? validateNewPassword(String? value, String currentPassword) {
    if (value == null || value.isEmpty) return 'Please enter a new password';
    if (value == currentPassword) {
      return 'New password must be different from current';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }
    if (value != newPassword) return 'Passwords do not match';
    return null;
  }

  static void logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogOut());
  }

  static void goToWelcome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  static void goToEditProfile(BuildContext context, UserModel user) =>
      pushScreen(context, EditProfilePage(user: user));

  static void goToUpdatePassword(BuildContext context) =>
      pushScreen(context, UpdatePasswordScreen());

  static void goToNotifications(BuildContext context) =>
      pushScreen(context, NotificationsScreen());

  static void goToOrders(BuildContext context) =>
      pushScreen(context, OrdersScreen());

  static void goToCart(BuildContext context) =>
      pushScreen(context, const MyCartPage());

  static void goToShippingAddress(BuildContext context) =>
      pushScreen(context, AddressCredScreen());

  static void goToWishlist(BuildContext context) =>
      pushScreen(context, const SavedItemsScreen());
}
