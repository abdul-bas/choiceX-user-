import 'package:coice/core/utils/parsers/to_user_model.dart';
import 'package:coice/data/models/review_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/rating_event.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/custom_text_form_field.dart';

import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void showRatingBottomSheet(
    {required BuildContext context,
    required TextEditingController reviewController,
    required String ratingKey,
    required String productId,
   required int variantIndex,
    required String userId,
    double? rate = 0}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 12,
          right: 12,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -3),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(height: 20),
            Center(
              child: TextInter(
                text: 'Share Your Feedback',
                letterSpacing: 0.5,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextInter(
              text: 'How was your order?',
              letterSpacing: 0.5,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 5),
            TextInter(
              text: 'Please give your rating and also your review',
              letterSpacing: 0.5,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 20),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 35,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rate = rating;
                  print(rate);
                },
              ),
            ),
            const SizedBox(height: 20),
            AuthTextFormField(
              controller: reviewController,
              text: 'Write your Review',
              isFocused: true,
              maxLines: 4,
            ),
            const SizedBox(height: 40),
            StreamBuilder(
                stream: AuthRepository().userData(),
                builder: (context, asyncSnapshot) {
                  final resulte = handleSnapshot(asyncSnapshot);
                  if (resulte != null) return resulte;
              final currentUser=    toUserModel(asyncSnapshot);
                  return AuthButton(
                    width: double.infinity,
                    text: 'Submit',
                    textColor: Colors.white,
                    function: () {
                      context.read<AuthBloc>().add(TakeRating(
                            productId: productId,variantIndex:variantIndex ,
                            key: ratingKey,
                            review: ReviewDataModel(
                                id: ratingKey,
                                userId: userId,
                                userName: currentUser!.name,
                                email: currentUser.email,
                                rating: rate ?? 0,
                                review: reviewController.text,
                                verified: true,
                                date: DateTime.now().toIso8601String()),
                          ));
                      Navigator.pop(context);
                    },
                  );
                }),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
