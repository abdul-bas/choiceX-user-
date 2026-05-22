import 'dart:math';

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/auth/bloc_auth_dispatcher.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _rotation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeInOutCubic),
      ),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.40, curve: Curves.easeIn),
      ),
    );

    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.60, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.brand,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fade,
                        child: ScaleTransition(
                          scale: _scale,
                          child: Transform.rotate(
                            angle: _rotation.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      height: height * 0.6,
                      decoration: const BoxDecoration(
                        color: AppColors.transparent,
                        image: DecorationImage(
                          image: AssetImage('assets/images/Choice_.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const CircularProgressIndicator(
                    strokeWidth: 7,
                    backgroundColor: AppColors.splashIndicatorBg,
                    color: AppColors.splashIndicatorColor,
                  ),
                  BlocAuthDispatcher(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
