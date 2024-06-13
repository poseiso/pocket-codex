import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'home_controller.dart';
import 'widgets/pokemon_item.dart';

class HomePage extends GetView<HomeController> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: statusBarHeight + 16.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Pokedex",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: controller.obx(
                  (state) => GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: state?.length ?? 0,
                    itemBuilder: (context, i) {
                      final item = state![i];
                      return PokemonItem(
                        id: item.id,
                        name: item.name,
                        types: item.types,
                        onTap: () => Get.toNamed(
                          AppRoutes.pokemonDetail,
                          arguments: {'detail': item},
                        ),
                      );
                    },
                    //         )
                  ),
                  onLoading: const Text("Loading"),
                  onError: (error) {
                    return Text("error $error");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
