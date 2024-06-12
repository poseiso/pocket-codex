import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_codex/app/screens/home/home.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = Get.mediaQuery.padding.top;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: statusBarHeight - 240 * 0.4,
            left: Get.width - (240 * 0.6),
            child: Image.asset(
              'assets/images/pokeball.png',
              opacity: const AlwaysStoppedAnimation(0.1),
              width: 240.0,
              height: 240.0,
            ),
          ),
          Column(
            children: [
              SizedBox(height: statusBarHeight + 240 * 0.4),
              const Text(
                "Pokedex",
                style: TextStyle(
                  color: Color.fromARGB(255, 48, 57, 67),
                  fontFamily: 'Google',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
