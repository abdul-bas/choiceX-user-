

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/chat/chat_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:coice/state/provider/chat_search_provider.dart';
import 'package:coice/ui/screens/chat/chat/widgets/chat_list_item.dart';
import 'package:coice/ui/screens/chat/messages/message_screen.dart';
import 'package:coice/ui/screens/search/chat_search/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ChatSearchScreen extends StatelessWidget {
  const ChatSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = AuthRepository().getUeserId();

    return ChangeNotifierProvider(
      create: (_) => ChatSearchProvider(),
      child: Builder(
        builder: (context) {
          final provider = context.read<ChatSearchProvider>();

          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              leadingWidth: 56,

              leading: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),

              title: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.grey300,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppColors.grey400,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: provider.searchCtrl,
                        autofocus: true,
                        onChanged: provider.onSearch,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search conversations...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    context.watch<ChatSearchProvider>().query.isNotEmpty
                        ? GestureDetector(
                            onTap: provider.clearSearch,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 11,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(width: 10),
                  ],
                ),
              ),
            ),

            body: StreamBuilder(
              stream: ChatRepository().getChats(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final chats = snapshot.data!
                      .map((d) => ChatModel.fromMap(d.data()))
                      .where((c) => c.userId == userId)
                      .toList();

                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => provider.setChats(chats),
                  );
                }

                return Consumer<ChatSearchProvider>(
                  builder: (context, p, _) {
                    if (p.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.brand,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Something went wrong',
                          style: TextStyle(
                            color: AppColors.black40,
                          ),
                        ),
                      );
                    }

                    if (p.filtered.isEmpty) {
                      return ChatSearchEmptySearchState(query: p.query);
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      itemCount: p.filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final chat = p.filtered[index];

                        return ChatListItem(
                          chat: chat,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                sellerId: chat.sellerId,
                                chatId: chat.chatId,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
