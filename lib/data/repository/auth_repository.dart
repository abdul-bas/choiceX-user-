import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/models/review_model.dart';
import 'package:coice/state/bloc/auth/states/edit_profile_states.dart';
import 'package:coice/state/bloc/auth/states/orders_state.dart';
import 'package:coice/state/bloc/auth/states/update_password_states.dart';
import 'package:coice/ui/screens/user_dashboard/DashboardScreen.dart';
import 'package:coice/state/bloc/auth/states/rating_state.dart';
import 'package:coice/ui/screens/auth/singn_in.dart';
import 'package:coice/ui/screens/auth/sign_up.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/models/user_model.dart';
import 'package:coice/state/bloc/auth/states/address_state.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/state/bloc/auth/states/cart_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String getPhoneNumber() {
    if (_auth.currentUser == null) {
      return '9295899618';
    }
    return _auth.currentUser!.phoneNumber ?? '9526758422';
  }

  Future<AuthState> signUp(UserModel model) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: model.email.trim(), password: model.password.trim());
      User? user = userCredential.user;
      await _fcm.requestPermission();
      String? token = await _fcm.getToken();
      model.fcmToken = token;
      await _firestore.collection('user').doc(user!.uid).set(model.toMap());
      final currentUser = _auth.currentUser;
      if (currentUser != null && !currentUser.emailVerified) {
        await currentUser.sendEmailVerification();
      }

      return AuthSuccess(
          message: 'User registered successfully. Please verify your email',
          subText: 'Verification email sent',
          buttonText: 'Continue',
          icon: Icons.email_outlined,
          normalColor: Colors.blue,
          transparentColor: Colors.blue.withValues(alpha: 0.2),
          navigationRomoveUntil: DashboardScreen());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      String subText = 'Please try again';
      String buttonText = 'Retry';
      Widget? navigation;
      bool? pop;

      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email address is already in use.';
        subText = 'Try logging in or use another email.';
        navigation = SignInScreen();
        buttonText = 'Login';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
        subText = 'Please use a stronger password.';
        pop = true;
        buttonText = 'Retry';
      } else {
        errorMessage = e.message ?? 'Sign-up failed';
        buttonText = 'OK';
        pop = true;
      }

      return AuthError(
        message: errorMessage,
        subText: subText,
        buttonText: buttonText,
        icon: Icons.error_outline,
        navigationReplace: navigation,
        pop: pop,
      );
    } catch (e) {
      return AuthError(
        message: 'Unexpected error: $e',
        subText: 'Try again later',
        buttonText: 'OK',
      );
    }
  }

  Future<AuthState> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          return AuthSuccess(
            message: 'User signed in successfully',
            subText: 'Welcome back!',
            buttonText: 'Continue',
            icon: Icons.login_rounded,
            normalColor: Colors.green,
            transparentColor: Colors.green.withValues(alpha: 0.2),
            navigationRomoveUntil: DashboardScreen(),
          );
        } else {
          return AuthError(
            message: 'Email not verified. Please verify your email first.',
            subText: 'Verification link has been sent to your inbox.',
            buttonText: 'Check Email',
            icon: Icons.email_outlined,
            normalColor: Colors.orange,
            transparentColor: Colors.orange.withValues(alpha: 0.2),
            pop: true,
          );
        }
      } else {
        return AuthError(
            message: 'Sign-in failed. User not found.',
            subText: 'Please check your credentials.',
            buttonText: 'Try Again',
            icon: Icons.error_outline,
            normalColor: Colors.red,
            transparentColor: Colors.red.withValues(alpha: 0.2),
            pop: true);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      String subText = 'Please try again';
      String buttonText;
      Widget? navigationReplace;

      bool? pop;

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for this email.';
        buttonText = 'Sign Up';
        navigationReplace = SignUpScreen();
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
        buttonText = 'Retry';
        pop = true;
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many attempts. Try again later.';
        pop = true;
        buttonText = 'OK';
      } else {
        errorMessage = e.message ?? 'Sign-in failed';
        pop = true;
        buttonText = 'Retry';
      }
      return AuthError(
        message: errorMessage,
        subText: subText,
        buttonText: buttonText,
        icon: Icons.warning_amber_rounded,
        navigationReplace: navigationReplace,
        pop: pop,
        normalColor: Colors.red,
        // ignore: deprecated_member_use
        transparentColor: Colors.red.withValues(alpha: 0.2),
      );
    } catch (e) {
      return AuthError(
          message: 'An unexpected error occurred: $e',
          subText: 'Something went wrong, please try again.',
          buttonText: 'OK',
          icon: Icons.error,
          normalColor: Colors.red,
          // ignore: deprecated_member_use
          transparentColor: Colors.red.withValues(alpha: 0.2),
          pop: true);
    }
  }

  Future<AuthState> passwordUpdate(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return AuthSuccess(
        message: 'Password reset email sent successfully.',
        subText: 'Please check your inbox to reset your password.',
        buttonText: 'OK',
        icon: Icons.email_outlined,
        pop: true,
        normalColor: Colors.blue,
        transparentColor: Colors.blue.withValues(alpha: 0.2),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      String subText = 'Please try again';
      String buttonText;
      Widget? navigation;
      bool? pop;

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for this email.';
        buttonText = 'Sign Up';
        navigation = SignUpScreen();
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
        buttonText = 'Retry';
        pop = true;
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many attempts. Try again later.';
        buttonText = 'OK';
        pop = true;
      } else {
        errorMessage = e.message ?? 'Password reset failed';
        buttonText = 'Retry';
        pop = true;
      }
      return AuthError(
        message: errorMessage,
        subText: subText,
        buttonText: buttonText,
        icon: Icons.warning_amber_rounded,
        navigationReplace: navigation,
        pop: pop,
        normalColor: Colors.orange,
        transparentColor: Colors.orange.withValues(alpha: 0.2),
      );
    } catch (e) {
      return AuthError(
        message: 'Unexpected error: $e',
        subText: 'Something went wrong. Please try again later.',
        buttonText: 'OK',
        pop: true,
        icon: Icons.error_outline,
        normalColor: Colors.red,
        transparentColor: Colors.red.withValues(alpha: 0.2),
      );
    }
  }

  Future<AuthState> auth() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return UserValidation(true);
      } else {
        return UserValidation(false);
      }
    } catch (e) {
      return UserValidation(false);
    }
  }

  Future<AuthState> signOut() async {
    try {
      await _auth.signOut();

      return AuthLogOutSuccess('User logged out successfully');
    } on FirebaseAuthException catch (e) {
      return AuthLogOutError('Logout failed: ${e.message}');
    } catch (e) {
      return AuthLogOutError('Logout failed: $e');
    }
  }

  Future<AuthState?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return SocialAuthError(
          message: 'Google Sign-In canceled by user',
          icon: Icons.error_outline,
          backgroundColor: Colors.orange,
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        final userDoc = await _firestore.collection('user').doc(user.uid).get();
        if (!userDoc.exists) {
          final newUser = UserModel(
              name: user.displayName ?? '',
              email: user.email ?? '',
              password: '',
              uid: user.uid,
              fcmToken: '',
              createdAt: DateTime.now());
          await _firestore
              .collection('user')
              .doc(user.uid)
              .set(newUser.toMap());
          return SocialAuthSuccess(
            user: newUser,
            message: 'Google sign-in successful (new user)',
            icon: Icons.check_circle,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          );
        } else {
          return SocialAuthSuccess(
            user: UserModel.fromMap(userDoc.data()!),
            message: 'Google sign-in successful (existing user)',
            icon: Icons.check_circle,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          );
        }
      }
      return SocialAuthError(
        message: 'Google sign-in failed: No user data',
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      return SocialAuthError(
        message: 'Google sign-in failed: $e',
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<AuthState?> signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          final userModel = UserModel.fromMap(userDoc.data()!);

          return SocialAuthSuccess(
            user: userModel,
            message: 'Facebook sign-in successful',
            icon: Icons.check_circle,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          );
        } else {
          return SocialAuthError(
              message: 'New Facebook user, additional setup required',
              icon: Icons.error_outline,
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3));
        }
      } else if (result.status == LoginStatus.cancelled) {
        return SocialAuthError(
          message: "Facebook Sign-In failed: ${result.message}",
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
        );
      } else {
        return SocialAuthError(
          message: result.message != null
              ? "Facebook Sign-In failed: ${result.message}"
              : "Facebook Sign-In cancelled",
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      return SocialAuthError(
        message: "Facebook Sign-In exception: $e",
        icon: Icons.error_outline,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<AuthState> makeFavorite(
      String productId, int variantIndex, bool value) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) return FavoriteError(message: "User not logged in");

      final userRef = _firestore.collection('user').doc(user.uid);

      final favoriteItem = {
        'productId': productId,
        'variantIndex': variantIndex,
      };

      if (value) {
        await userRef.update({
          'favorites': FieldValue.arrayUnion([favoriteItem])
        });
      } else {
        await userRef.update({
          'favorites': FieldValue.arrayRemove([favoriteItem])
        });
      }

      return FavoriteSuccess(message: "Favorite updated successfully");
    } catch (e) {
      return FavoriteError(message: "Failed to update favorite: $e");
    }
  }

  Future<AuthState> addCart({required CartModel cart}) async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return FavoriteError(message: "User not logged in");
      }

      final cartCollection =
          _firestore.collection('cart').doc(user.uid).collection('items');

      final existingItem = await cartCollection
          .where(
            'productId',
            isEqualTo: cart.productId,
          )
          .where('variantIndex', isEqualTo: cart.variantIndex)
          .limit(1)
          .get();

      if (existingItem.docs.isNotEmpty) {
        final doc = existingItem.docs.first;

        final currentQty = doc['quantity'] ?? 1;

        await doc.reference.update({
          'quantity': currentQty + 1,
        });

        return CartSuccessfullyAdded(
          message: "Quantity updated in cart",
          productName: cart.productName,
          price: cart.price.toString(),
          addedTime: DateTime.now(),
        );
      } else {
        await cartCollection.add({
          ...cart.toMap(),
          'quantity': 1,
        });
        await _firestore.collection('cart').doc('count').set({'count':FieldValue.increment(1)},SetOptions(merge: true));

        return CartSuccessfullyAdded(
          message: "Product added to cart successfully",
          productName: cart.productName,
          price: cart.price.toString(),
          addedTime: DateTime.now(),
        );
      }
    } catch (e) {
      return FavoriteError(message: "Failed to update cart: $e");
    }
  }
   Stream<int> cartCountStream() {
  return _firestore
      .collection('cart')
      .doc('count')
      .snapshots()
      .map((snapshot) {
    if (!snapshot.exists) return 0;

    return snapshot.data()?['count'] ?? 0;
  });
}
Future<void> clearCartCount() async {
  await _firestore
      .collection('cart')
      .doc('count')
      .set({
    'count': 0,
  },SetOptions(merge: true));
}
  Future<AuthState> incrementQuantity({
    required String productId,
    required int variantIndex,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return FavoriteError(message: "User not logged in");
      }

      final cartCollection =
          _firestore.collection('cart').doc(user.uid).collection('items');

      final query = await cartCollection
          .where('productId', isEqualTo: productId)
          .where('variantIndex', isEqualTo: variantIndex)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;

        await doc.reference.update({
          'quantity': FieldValue.increment(1),
        });

        return CartSuccessfullyAdded(
          message: "Quantity increased",
          productName: "",
          price: "",
          addedTime: DateTime.now(),
        );
      }

      return FavoriteError(message: "Item not found");
    } catch (e) {
      return FavoriteError(message: "Error: $e");
    }
  }

  Future<AuthState> deleteCartItem({
    required String productId,
    required int variantIndex,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return FavoriteError(message: "User not logged in");
      }

      final cartCollection =
          _firestore.collection('cart').doc(user.uid).collection('items');

      final query = await cartCollection
          .where('productId', isEqualTo: productId)
          .where('variantIndex', isEqualTo: variantIndex)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();

        return CartSuccessfullyAdded(
          message: "Item removed from cart",
          productName: "",
          price: "",
          addedTime: DateTime.now(),
        );
      }

      return FavoriteError(message: "Item not found");
    } catch (e) {
      return FavoriteError(message: "Failed to delete item: $e");
    }
  }

  Future<AuthState> decrementQuantity({
    required String productId,
    required int variantIndex,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return FavoriteError(message: "User not logged in");
      }

      final cartCollection =
          _firestore.collection('cart').doc(user.uid).collection('items');

      final query = await cartCollection
          .where('productId', isEqualTo: productId)
          .where('variantIndex', isEqualTo: variantIndex)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        final currentQty = doc['quantity'] ?? 1;

        if (currentQty <= 1) {
          await doc.reference.delete();

          return CartSuccessfullyAdded(
            message: "Item removed from cart",
            productName: "",
            price: "",
            addedTime: DateTime.now(),
          );
        } else {
          await doc.reference.update({
            'quantity': FieldValue.increment(-1),
          });

          return CartSuccessfullyAdded(
            message: "Quantity decreased",
            productName: "",
            price: "",
            addedTime: DateTime.now(),
          );
        }
      }

      return FavoriteError(message: "Item not found");
    } catch (e) {
      return FavoriteError(message: "Error: $e");
    }
  }

  Future<double> getCartSubTotal() async {
    final user = _auth.currentUser;

    if (user == null) {
      return 0.0;
    }

    final cartCollection =
        _firestore.collection('cart').doc(user.uid).collection('items');

    final snapshot = await cartCollection.get();

    double subtotal = 0.0;

    for (var doc in snapshot.docs) {
      final data = doc.data();

      final price = (data['discountPrice'] ?? 0).toDouble();
      final qty = (data['quantity'] ?? 1);

      subtotal += price * qty;
    }

    return subtotal;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCartItemsStream() {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    return _firestore
        .collection('cart')
        .doc(user.uid)
        .collection('items')
        .snapshots();
  }

  Future<AuthState> clearCart() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return FavoriteError(message: "User not logged in");
      }

      final cartCollection =
          _firestore.collection('cart').doc(user.uid).collection('items');

      final snapshot = await cartCollection.get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      return CartSuccessfullyAdded(
        message: "Cart cleared successfully",
        productName: "",
        price: "",
        addedTime: DateTime.now(),
      );
    } catch (e) {
      return FavoriteError(message: "Failed to clear cart: $e");
    }
  }

  Future<void> deleteCart() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('user').doc(user.uid).update({
      'cart': FieldValue.delete(),
    });
  }

  Future<AuthState> addAdress(AddressModel address) async {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return AddAddressError(
        title: 'User Error',
        subTitle: 'User not logged in',
      );
    }

    try {
      if (address.isDefault == true) {
        final snapshot = await _firestore
            .collection('userAddress')
            .doc(currentUser.uid)
            .collection('addresses')
            .get();

        if (snapshot.docs.isNotEmpty) {
          for (var doc in snapshot.docs) {
            if (doc.data()['isDefault'] == true) {
              await doc.reference.update({'IsDefault': false});
            }
          }
        }
      }
      final docRef = _firestore
          .collection('userAddress')
          .doc(currentUser.uid)
          .collection('addresses')
          .doc();
      address.id = docRef.id;

      await docRef.set(
        address.toMap(),
        SetOptions(merge: true),
      );
      return AddAddressSuccess(
        title: 'Success',
        subTitle: 'Address added successfully',
      );
    } catch (e) {
      return AddAddressError(
        title: 'Firestore Error',
        subTitle: e.toString(),
      );
    }
  }

  Future<AuthState> deleteExistingAddress({
    required int index,
  }) async {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return AddAddressError(
        title: 'User Error',
        subTitle: 'User not logged in',
      );
    }

    final userRef = _firestore.collection('user').doc(currentUser.uid);
    final userDoc = await userRef.get();

    if (!userDoc.exists || userDoc.data() == null) {
      return AddAddressError(
        title: 'Profile Error',
        subTitle: 'User data not found',
      );
    }

    final data = userDoc.data()!;

    List existingAddress = List.from(data['Address']);

    existingAddress.removeAt(index);

    await userRef.update({
      'Address': existingAddress,
    });

    return AddAddressSuccess(
      title: 'Success',
      subTitle: 'Address added successfully',
    );
  }

  Stream<DocumentSnapshot<Object?>> userData() {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    return _firestore
        .collection('user')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) => snapshot);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    final User? user = _auth.currentUser;

    return _firestore.collection('user').doc(user!.uid).get();
  }

  String getUeserId() {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    return user.uid;
  }

  Future<bool> addressEmptyOrNot() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return false;
    }

    final snapshot = await _firestore
        .collection('userAddress')
        .doc(user.uid)
        .collection('addresses')
        .get();

    if (snapshot.docs.isEmpty) {
      return false;
    }

    return snapshot.docs.any((address) => address.data()['IsDefault'] == true);
  }

  Future<AuthState> placeOrder({required List<OrderModel> model}) async {
    try {
      for (int i = 0; i < model.length; i++) {
        final id = _firestore.collection('orders').doc().id;

        model[i].orderId = id;

        await _firestore.collection('orders').doc(id).set(model[i].toMap());
      }

      return OrdersSuccessState();
    } catch (e) {
      return OrdersErrorState(e.toString());
    }
  }

  Future<AuthState> setRating({
    required String productId,
    required String key,
    required int variantIndex,
    required ReviewDataModel review,
  }) async {
    try {
      final docRef = _firestore
          .collection('product')
          .doc(productId)
          .collection('rating')
          .doc(key);
      await docRef.set(review.toMap());

      return RatingUpdated(message: 'success');
    } catch (e) {
      return RatingUpdated(message: e.toString());
    }
  }

  Future<bool> isReviewed({
    required String productId,
    required String key,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('product')
          .doc(productId)
          .collection('rating')
          .doc(key)
          .get();

      if (!snapshot.exists) return false;

      final data = snapshot.data();

      return data?['verified'] ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> readReview(
      {required String productId, required int variantIndex}) async {
    try {
      final snapshot = await _firestore
          .collection('product')
          .doc(productId)
          .collection('rating')
          .get();

      if (snapshot.docs.isEmpty) return [];

      return snapshot.docs
          .where((doc) {
            final id = doc['id'].split('_');
            if (id[1] == productId && id[2] == variantIndex.toString()) {
              return true;
            }
            return false;
          })
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<AuthState> editProfile({
    required UserModel updatedUser,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return EditProfileFailure(
          error: 'User not logged in',
        );
      }

      if (user.email != updatedUser.email) {
        await user.verifyBeforeUpdateEmail(
          updatedUser.email,
        );
      }

      final userRef = _firestore.collection('user').doc(user.uid);

      await userRef.set({
        'uid': user.uid,
        'name': updatedUser.name,
        'email': updatedUser.email,
        'image': updatedUser.image,
        'fcmToken': updatedUser.fcmToken,
        'createdAt': updatedUser.createdAt.toIso8601String(),
      }, SetOptions(merge: true));

      return EditProfileSuccess();
    } on FirebaseAuthException catch (e) {
    
      return EditProfileFailure(
        error: e.message ?? 'Profile update failed',
      );
    } catch (e) {
      return EditProfileFailure(
        error: e.toString(),
      );
    }
  }

  Future<AuthState> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return ChangePasswordFailure(error: 'User not logged in');
      }
      final email = user.email.toString();
      final credential = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      return ChangePasswordSuccess();
    } on FirebaseAuthException catch (e) {
      print('\nFirebaseAuthException: ${e.code}\n\n');
      return ChangePasswordFailure(
        error: e.message ?? 'Password update failed',
      );
    } catch (e) {
      print('\nError: $e\n\n');
      return ChangePasswordFailure(
        error: 'Something went wrong',
      );
    }
  }

  getCouponCode(String code) async {
    final query = await _firestore
        .collection('coupon')
        .where('code', isEqualTo: code)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return query.docs.first;
  }

  void setUserOnlineStatus(String uid) {
    final ref = FirebaseDatabase.instance.ref('status/$uid');

    ref.onDisconnect().update({
      'online': false,
      'lastSeen': ServerValue.timestamp,
    });

    ref.update({
      'online': true,
      'lastSeen': ServerValue.timestamp,
    });
  }
}
