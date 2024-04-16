import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/utils.dart';

class SplashAnimationWidget extends StatefulWidget {
  const SplashAnimationWidget({super.key});

  @override
  SplashAnimationWidgetState createState() => SplashAnimationWidgetState();
}

class SplashAnimationWidgetState extends State<SplashAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() => setState(() {}));

    _colorAnimation = ColorTween(begin: AppColors.closed, end: AppColors.star)
        .animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              children: [
                Text(
                  AppWords.restauranTour,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: _colorAnimation.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  ImagePath.chef,
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
