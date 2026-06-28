import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/routes/push_function.dart';
import 'package:coice/core/utils/parsers/to_product_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/state/provider/home_controller.dart';
import 'package:coice/ui/screens/favorite/favorite_screen.dart';
import 'package:coice/ui/screens/home/home.dart';
import 'package:coice/ui/screens/chat/chat/chat_screen.dart';
import 'package:coice/ui/screens/more/more_screen.dart';
import 'package:coice/core/utils/handlers/product_stream_handler.dart';
import 'package:coice/ui/screens/user_dashboard/widgets/homeHeader.dart';
import 'package:coice/ui/screens/user_dashboard/widgets/nave_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: const HomeHeader(),
      body: StreamBuilder(
        stream: UiDetailsGet().productGet(),
        builder: (context, snapshot) {
          final result = streamHandler(snapshot);
          if (result is Widget) return result;

          final products = toProductModel(snapshot);

          return Selector<HomeController, int>(
            selector: (_, controller) => controller.bottomNavigationIndex,
            builder: (context, index, _) {
              return SizedBox.expand(
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: constraints.maxHeight,
                          child: [
                            HomeScreen(products: products),
                            UserChatScreen(),
                            FavoriteScreen(),
                          ][index],
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: 15,
                      right: 15,
                      child: DashboardNavBar(
                        currentIndex: index,
                        onTap: (i) {
                          if (i == 3) {
                            pushScreen(context, MoreScreen());
                            return;
                          }
                          context
                              .read<HomeController>()
                              .setBottomNavigationIndex(i);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}