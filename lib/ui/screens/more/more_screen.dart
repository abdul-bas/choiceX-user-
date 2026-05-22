

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/screens/more/controller/profile_controller.dart';
import 'package:coice/ui/screens/more/listeners/log_out.dart';
import 'package:coice/ui/screens/more/log_out_dialog/log_out_dialog.dart';
import 'package:coice/ui/screens/more/widgets/divider_widget.dart';
import 'package:coice/ui/screens/more/widgets/menu_card_widget.dart';
import 'package:coice/ui/screens/more/widgets/menu_item_widget.dart';
import 'package:coice/ui/screens/more/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,        
      body: StreamBuilder(
        stream: ProfileController.getUserStream(),    
        builder: (context, snapshot) {
          final result = handleSnapshot(snapshot);
          if (result != null) return result;

          final currentUser = ProfileController.parseUser(snapshot); 
          if (currentUser == null) {
            return const Text('no current currentUser');
          }

          return logOutListener(
            context: context,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: AppColors.white), 
      ),
      expandedHeight: 250,
      collapsedHeight: 80,
      backgroundColor: AppColors.transparent,         
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.profileHeaderGradient, 
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(100),
            ),
          ),
          child: Stack(
            children: [
             
              Positioned(
                top: -50, right: -30,
                child: Container(
                  width: 150, height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha:  0.1), 
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -30, left: -20,
                child: Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha:  0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: 130, height: 130,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceWhite,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 5, color: AppColors.brand), 
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowAvatar, 
                              blurRadius: 20,
                              spreadRadius: 1,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            currentUser.name.isNotEmpty ? currentUser.name[0] : '',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: AppColors.brand,  
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: TextInter(
                        text: currentUser.name,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,      
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextInter(
                        text: currentUser.email,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,        
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 20),
                    buildSectionTitle('General'),
                    buildMenuCard(children: [
                      buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        subtitle: 'Update your personal information',
                        onTap: () => ProfileController.goToEditProfile( 
                            context, currentUser),
                      ),
                      buildDivider(),
                      buildMenuItem(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        subtitle: 'Manage your account security',
                        onTap: () =>
                            ProfileController.goToUpdatePassword(context), 
                      ),
                      buildDivider(),
                      buildMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Customize your alerts',
                        onTap: () =>
                            ProfileController.goToNotifications(context), 
                      ),
                      buildDivider(),
                      buildMenuItem(
                        icon: Icons.shopping_bag_outlined,
                        title: 'My Orders',
                        subtitle: 'Track your purchases',
                        onTap: () =>
                            ProfileController.goToOrders(context), 
                      ),
                      buildDivider(),
                      buildMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        title: 'Cart',
                        subtitle: 'View your shopping cart',
                        onTap: () =>
                            ProfileController.goToCart(context), 
                      ),
                    ]),
                    const SizedBox(height: 20),
                    buildSectionTitle('Account'),
                    buildMenuCard(children: [
                      buildMenuItem(
                        icon: Icons.location_on_outlined,
                        title: 'Shipping Address',
                        subtitle: 'Manage delivery locations',
                        onTap: () =>
                            ProfileController.goToShippingAddress(context), 
                      ),
                      buildDivider(),
                      buildMenuItem(
                        icon: Icons.favorite_outline,
                        title: 'Wishlist',
                        subtitle: 'Your saved items',
                        onTap: () =>
                            ProfileController.goToWishlist(context), 
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: AuthButton(
                        function: () => showDialog(
                          context: context,
                          builder: (_) => const LogOutDialog(),
                        ),
                        text: 'Log Out',
                        textColor: AppColors.white,    
                        width: double.infinity,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}








