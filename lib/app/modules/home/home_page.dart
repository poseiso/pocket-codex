import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_codex/app/common/widget_error.dart';
import 'package:pocket_codex/app/common/widget_loading.dart';

import '../../routes/app_pages.dart';
import 'home_controller.dart';
import 'widgets/pokemon_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -90,
            right: -100,
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
              const SizedBox(height: 42.0),
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
              Row(
                children: [
                  const SizedBox(width: 12.0),
                  Container(
                    height: 42.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Obx(()=>DropdownButton<String>(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      value: controller.filter.value,
                      hint: const Text('Type'),
                      underline: const SizedBox(),
                      onChanged: (newValue) {
                        controller.onChangeFilter(newValue ?? "All Type");
                      },
                      items: controller.pokemonTypes.map((filter) {
                        return DropdownMenuItem<String>(
                          value: filter.name,
                          child: Text(filter.name.capitalize!),
                        );
                      }).toList(),
                    ),
                  )),
                  const SizedBox(width: 12.0),
                  Container(
                    height: 42.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Obx(()=>DropdownButton<String>(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      value: controller.sort.value,
                      hint: const Text('Sort'),
                      underline: const SizedBox(),
                      onChanged: (newValue) {
                        controller.onChangeSort(newValue ?? "Id Ascending");
                      },
                      items: controller.sortList.map((filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                      icon: const Icon(Icons.sort_rounded),
                    ),
                  )),
                  const SizedBox(width: 12.0),
                ],
              ),
              const SizedBox(height: 12.0),
              Expanded(
                child: controller.obx(
                  (state) => GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    controller: controller.scrollController,
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
                  onLoading: const LoadingLogo(),
                  onError: (error) {
                    return WidgetError(
                      onReload: controller.fetchAllPokemon,
                      error: error ?? "",
                    );
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
