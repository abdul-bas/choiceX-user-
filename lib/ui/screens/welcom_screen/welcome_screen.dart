import 'package:carousel_slider/carousel_slider.dart';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/constants/slider_data.dart';
import 'package:coice/ui/screens/auth/sign_up.dart';
import 'package:coice/ui/screens/auth/singn_in.dart';
import 'package:coice/state/bloc/page_index/page_bloc.dart';
import 'package:coice/state/bloc/page_index/page_event.dart';
import 'package:coice/state/bloc/page_index/page_state.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_cripson.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: CarouselSlider(
                  items: sliderData.map((i) {
                    return Builder(
                      builder: (context) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 300,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: AssetImage(i['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: SizedBox(
                              width: 270,
                              child: TextCrimson(
                                text: i['text']!,
                                maxLine: 2,
                                textOverflow: TextOverflow.ellipsis,
                                fontSize: 23,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 5 / 6.5,
                    onPageChanged: (newIndex, reason) {
                      context
                          .read<PageViewBloc>()
                          .add(ToggleIndex(index: newIndex));
                    },
                    viewportFraction: 1.0,
                    reverse: true,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextInter(
                text: 'Shop Smarter. Live Better',
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 40),
              BlocBuilder<PageViewBloc, PageState>(
                builder: (context, state) {
                  final index = state is ToggleIndexSuccess ? state.index : 0;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedSmoothIndicator(
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: AppColors.brand,
                      ),
                      activeIndex: index,
                      count: 3,
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  AuthButton(
                    width: width,
                    function: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()),
                    ),
                    text: 'Create Account',
                    textColor: AppColors.white,
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignInScreen()),
                    ),
                    child: TextSlab(
                      text: 'Already Have an Account',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
