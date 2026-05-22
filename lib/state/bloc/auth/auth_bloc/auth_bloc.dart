import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/events/address_event.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/state/bloc/auth/events/edit_profile_event.dart';
import 'package:coice/state/bloc/auth/events/orders_event.dart';
import 'package:coice/state/bloc/auth/events/update_password_event.dart';
import 'package:coice/state/bloc/auth/states/edit_profile_states.dart';
import 'package:coice/state/bloc/auth/states/orders_state.dart';
import 'package:coice/state/bloc/auth/events/rating_event.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/state/bloc/auth/states/cart_state.dart';

import 'package:coice/state/bloc/auth/states/rating_state.dart';
import 'package:coice/state/bloc/auth/states/update_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository = AuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<SignUp>((event, emit) async {
      emit(AuthLoading());

      final resulte = await repository.signUp(event.model);
      emit(resulte);
    });
    on<SignIn>(
      (event, emit) async {
        emit(AuthLoading());
        final resulte = await repository.signIn(
            email: event.email, password: event.password);
        emit(resulte);
      },
    );
    on<EmailPassword>((event, emit) async {
      final resulte = await repository.passwordUpdate(event.email);
      emit(resulte);
    });
    // on<UpdatePassword>((event, emit) async {
    //   print('UpdatePassword event received: ${event.newPassword}');
    //   emit(AuthLoading());
    //   final resulte = await repository.(event.newPassword);
    //   emit(resulte);
    // });
    on<Authentication>((event, emit) async {
      emit(AuthLoading());
      final resulte = await repository.auth();
      emit(resulte);
    });
    on<AuthLogOut>((event, emit) async {
      emit(AuthLoading());
      final resulte = await repository.signOut();
      emit(resulte);
    });
    on<GoogleSignInEvent>(
      (event, emit) async {
        emit(AuthLoading());
        final resulte = await repository.signInWithGoogle();
        if (resulte != null) {
          emit(resulte);
        } else {
          emit(SocialAuthError(
            message: 'Google Sign-In Failed',
            icon: Icons.error_outline,
            backgroundColor: Colors.red,
          ));
        }
      },
    );
    on<FacebookSignInEvent>(
      (event, emit) async {
        emit(AuthLoading());
        final resulte = await repository.signInWithFacebook();
        if (resulte != null) {
          emit(resulte);
        } else {
          emit(SocialAuthError(
            message: 'Facebook Sign-In Failed',
            icon: Icons.error_outline,
            backgroundColor: Colors.red,
          ));
        }
      },
    );
    on<MakeandRmoveFavorite>(
      (event, emit) async {
        emit(AuthLoading());
        final resulte = await repository.makeFavorite(
            event.id, event.variantIndex, event.value);

        emit(resulte);
      },
    );
    on<AddCart>(
      (event, emit) async {
        emit(CartLoading());
        final resulte = await repository.addCart(cart:event.cart );

        emit(resulte);
      },
    );
    on<DeleteCart>(
      (event, emit) async {
        emit(CartLoading());
        final resulte =
            await repository.deleteCartItem(productId: event.productId,variantIndex: event.variantId);

        emit(resulte);
      },
    );
    on<AddAddressEvent>(
      (event, emit) async {
        emit(AuthLoading());
        final resulte = await repository.addAdress(
         event.addressModel  );

        emit(resulte);
      },
    );
    // on<UpdateAddress>(
    //   (event, emit) async {
    //     emit(AuthLoading());
    //     final resulte = await repository.updateExistingAddress(
    //         index: event.index,
    //         phoneNumber: event.phoneNumber,
    //         nickName: event.nickName,
    //         location: event.location,
    //         fullAddress: event.fullAddress,
    //         isDefault: event.isDefault);

    //     emit(resulte);
    //   },
    // );
    on<DeleteExistingAddress>(
      (event, emit) async {
        emit(AuthLoading());
        final resulte =
            await repository.deleteExistingAddress(index: event.index);

        emit(resulte);
      },
    );
    on<PlaceOrderEvent>(
      (event, emit) async {
        emit(OrdersLoadingState());
        final resulte = await repository.placeOrder(model: event.order);

        emit(resulte);
      },
    );
    on<TakeRating>(
      (event, emit) async {
        emit(RatingLoading());
        final resulte = await repository.setRating(variantIndex: event.variantIndex,
            productId: event.productId, review: event.review, key: event.key);

        emit(resulte);
      },
    );
    on<UpdateProfileEvent>(
      (event, emit) async {
        emit(EditProfileLoading());
        final resulte = await repository.editProfile(
          updatedUser: event.updatedUser);

        emit(resulte);
      },
    );
    on<UpdatePasswordEvent>(
      (event, emit) async {
        emit(ChangePasswordLoading());
        final resulte = await repository.updatePassword(
            oldPassword: event.oldPassword, newPassword: event.newPassword);

        emit(resulte);
      },
    );
  }
}
