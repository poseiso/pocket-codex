import 'dart:math';

import 'package:flutter/material.dart';

// Isolated StatefulWidget
// won't impact performance that much 
class LoadingLogo extends StatefulWidget {
  const LoadingLogo({super.key});

  @override
  LoadingLogoState createState() => LoadingLogoState();
}

class LoadingLogoState extends State<LoadingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            // 2 * pi = full circle
            angle: _controller.value * 2 * pi,
            child: Image.asset(
              'assets/images/pokeball.png',
              color: Colors.black12,
              width: 150,
              height: 150,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
