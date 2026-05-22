
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
class ChatSearchEmptySearchState extends StatelessWidget {
  const ChatSearchEmptySearchState({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.grey200,
                  width: 1,
                ),
              ),
              child: Icon(
                query.isEmpty
                    ? Icons.chat_bubble_outline_rounded
                    : Icons.search_off_rounded,
                size: 32,
                color: AppColors.black20,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              query.isEmpty
                  ? 'No conversations yet'
                  : 'No results for "$query"',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              query.isEmpty
                  ? 'Your conversations will appear here'
                  : 'Try a different search term',
              style: TextStyle(
                color: AppColors.black40,
                fontSize: 13,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}