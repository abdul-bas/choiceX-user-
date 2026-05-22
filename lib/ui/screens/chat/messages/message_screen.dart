import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/parsers/to_seller_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/core/utils/handlers/stream_handler.dart';
import 'package:coice/ui/screens/chat/messages/widgets/app_bar/app_bar.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/input_area.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_area.dart';
import 'package:coice/ui/screens/chat/messages/widgets/product_preview/product_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.sellerId,
    required this.chatId,
    ProductModel? product,
    this.variantIndex,
    this.receiverId,
  }) : product = ValueNotifier<ProductModel?>(product);

  final String sellerId;
  final String chatId;
  final String? receiverId;
  final int? variantIndex;
  final ValueNotifier<ProductModel?> product;
  final ValueNotifier<bool> isFocus = ValueNotifier(false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,           
        statusBarIconBrightness: Brightness.dark,
      ),
      child: StreamBuilder(
        stream: UiDetailsGet().sellerGet(sellerId), 
        builder: (context, snapshot) {
          final result = sellerStreamHandler(snapshot);
          if (result != null) return Scaffold(body: result);
          final seller = toSellerModel(snapshot);

          return Scaffold(
            backgroundColor: AppColors.surfaceLight,   
            appBar: messageAppBar(context, seller),
            body: Column(
              children: [
                Expanded(
                    child: messagesArea(
                        context, chatId, scrollController)),
                messageProductPreview(variantIndex, product),
                messageInputArea(context, isFocus, product,
                    variantIndex, chatId, sellerId, scrollController),
              ],
            ),
          );
        },
      ),
    );
  }
}



