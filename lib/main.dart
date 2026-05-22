
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/firebase_options.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/chat/chat_bloc.dart';
import 'package:coice/state/bloc/notification/notification_bloc.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_bloc.dart';
import 'package:coice/state/bloc/order/order_bloc/order_bloc.dart';
import 'package:coice/state/bloc/page_index/page_bloc.dart';
import 'package:coice/state/bloc/product/product_bloc/product_bloc.dart';
import 'package:coice/state/bloc/recent_search/recent_search_bloc.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/state/provider/audio_preview_provider.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/state/provider/filter_provider.dart';
import 'package:coice/state/provider/home_controller.dart';
import 'package:coice/state/provider/order_detail_provider.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/state/provider/profile_update_provider.dart';
import 'package:coice/state/provider/promo_code_pop_state.dart';
import 'package:coice/state/provider/simular_product_state.dart';
import 'package:coice/state/provider/wishlist_controller.dart';
import 'package:coice/ui/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey =
      'pk_test_51SYg0gImJBBi6PZmgW0MMcAsC3T5h1aEMokscIlxb5XEiX4a1dKrgRN85FlBbBV00UfgPEk8rCs5xJXBZhQqptMn00GAvsSgDR';
  await Permission.location.request();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      AuthRepository().setUserOnlineStatus(user.uid);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PageViewBloc()),
        BlocProvider(create: (context) => ObscureBloc()),
        BlocProvider(create: (context) => RecentSearchBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => OrderBloc()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartState()),
          ChangeNotifierProvider(create: (_) => FilterProvider()),
          ChangeNotifierProvider(create: (_) => PromoCodePopState()),
          ChangeNotifierProvider(create: (_) => AddressProvider()),
          ChangeNotifierProvider(create: (_) => SimilarProductState()),
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => ProductSearchController()),
          ChangeNotifierProvider(create: (_) => WishlistController()),
          ChangeNotifierProvider(create: (_) => OrderDetailProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider()),
          ChangeNotifierProvider(create: (_) => AudioPreviewProvider()), ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Choice_X',
          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: const Color(0xFFF6F7FB)),
            scaffoldBackgroundColor: const Color(0xFFF6F7FB),
            primaryColor: const Color.fromARGB(206, 77, 21, 174),
            tabBarTheme: TabBarThemeData(indicatorColor: Colors.black),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
