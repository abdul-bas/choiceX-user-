
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/user_model.dart';
import 'package:coice/state/provider/profile_update_provider.dart';
import 'package:coice/ui/screens/account/controller/controller.dart';
import 'package:coice/ui/screens/account/listeners/edit_profile_listener.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:coice/ui/common_widgets/cutom_text_form_field_with_label.dart';
import 'package:coice/ui/screens/account/widget/image_sorce_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider()..setUser(user),
      child: Consumer<EditProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: AppColors.surfaceWhite,

            appBar: AppBar(
              elevation: 0.5,
              backgroundColor: AppColors.surfaceWhite,

              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                ),
              ),

              title: TextSlab(
                text: 'Edit Profile',
                letterSpacing: 0.3,
                fontSize: 20,
              ),

              centerTitle: true,
            ),

            body: EditProfileBlocListener(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: provider.formKey,

                  child: ListView(
                    children: [
                      const SizedBox(height: 20),

                     
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  showImageSourceSheet(context),

                              child: Container(
                                width: 120,
                                height: 120,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.brand,

                                  image:
                                      provider.pickedImage != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                provider.pickedImage!,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          
                                            
                                              : null,
                                ),

                                child:
                                    provider.pickedImage == null &&
                                            user.image == null
                                        ? Center(
                                            child: TextInter(
                                              text:
                                                  EditProfileLogic
                                                      .avatarInitial(
                                                user.name,
                                              ),
                                              color:
                                                  AppColors.white,
                                              fontSize: 40,
                                            ),
                                          )
                                        : null,
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,

                              child: GestureDetector(
                                onTap: () =>
                                    showImageSourceSheet(context),

                                child: Container(
                                  padding:
                                      const EdgeInsets.all(6),

                                  decoration:
                                      const BoxDecoration(
                                    color: AppColors.brand,
                                    shape: BoxShape.circle,
                                  ),

                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: AppColors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                    
                      AuthTextFeild(
                        controller:
                            provider.userNameController,
                        radius: 10,
                        text: 'Enter Username',
                        hintText: 'username',
                        validator:
                            EditProfileLogic.validateUsername,
                      ),

                      const SizedBox(height: 20),

                      AuthTextFeild(
                        controller:
                            provider.emailController,
                        radius: 10,
                        text: 'Enter Email',
                        hintText: 'email',
                        validator:
                            EditProfileLogic.validateEmail,
                      ),

                      const SizedBox(height: 50),

                  
                      AuthButton(
                        width: double.infinity,
                        text: 'Edit Profile',
                        textColor: AppColors.white,

                        function: () =>
                            provider.submit(context, user),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}