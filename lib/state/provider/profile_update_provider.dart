import 'dart:io';

import 'package:coice/data/models/user_model.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/edit_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileProvider extends ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (picked != null) {
      _pickedImage = File(picked.path);
      notifyListeners();
    }
  }

  void setUser(UserModel user) {
    userNameController.text = user.name;
    emailController.text = user.email;
    

_pickedImage = user.image != null ? File(user.image!) : null;
    notifyListeners();
  }

  void submit(BuildContext context, UserModel user) {
    if (!formKey.currentState!.validate()) return;

    final name = userNameController.text.trim();
    final email = emailController.text.trim();

    context.read<AuthBloc>().add(
          UpdateProfileEvent(
            updatedUser: UserModel(
              uid: user.uid,
              name: name,
              email: email,
              password: user.password,
              image: _pickedImage?.path??user.image,
              fcmToken: user.fcmToken,
              createdAt: user.createdAt,
            ),
          ),
        );
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
