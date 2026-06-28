import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/routes/push_function.dart';
import 'package:coice/state/provider/home_controller.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:coice/ui/screens/home/controller/controller.dart';
import 'package:coice/ui/screens/more/notifications/notifications.dart';
import 'package:coice/ui/screens/search/chat_search/chat_search_screen.dart';
import 'package:coice/ui/screens/search/favorite_search/favorite_search_screen.dart';
import 'package:coice/ui/screens/search/product_search/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.grey200,
      title: const Text(
        'Choice_X',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
      ),
      actions: [
        StreamBuilder(
            stream: HomeLogic.authRepository.cartCountStream(),
            builder: (context, asyncSnapshot) {
              final data = asyncSnapshot.data;
              return IconButton(
                icon: Badge(
                  isLabelVisible: data != null && data > 0,
                  backgroundColor: AppColors.deleteRed,
                  textColor: AppColors.white,
                  label: Text('$data'),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
                onPressed: () {
                  HomeLogic.authRepository.clearCartCount();
                  pushScreen(context, MyCartPage());
                },
              );
            }),
        StreamBuilder(
            stream: HomeLogic.notificationRepository.notificationCountStream(),
            builder: (context, asyncSnapshot) {
              final data = asyncSnapshot.data;
              return IconButton(
                icon: Badge(
                    isLabelVisible: data != null && data > 0,
                    backgroundColor: AppColors.deleteRed,
                    textColor: AppColors.white,
                    label: Text('$data'),
                    child: Icon(Icons.notifications_outlined)),
                onPressed: () async{
               await   HomeLogic.notificationRepository.clearNotificationCount();
                  pushScreen(context, NotificationsScreen());
                },
              );
            }),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Selector<HomeController, int>(
            selector: (_, controller) => controller.bottomNavigationIndex,
            builder: (context, index, _) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TextField(
                  readOnly: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => [
                        SearchScreen(),
                        ChatSearchScreen(),
                        FavoriteSearchScreen(),
                      ][index],
                    ),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search gadgets, brands...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
