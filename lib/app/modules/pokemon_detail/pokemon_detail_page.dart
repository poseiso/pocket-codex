import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:pocket_codex/app/utils/app_config.dart';
import 'package:pocket_codex/app/utils/utils.dart';

import 'pokemon_detail.dart';
import '../../data/models/models.dart';

part 'widgets/widget_evolution.dart';
part 'widgets/widget_logo_background.dart';
part 'widgets/widget_stat.dart';
part 'widgets/widget_stat_chart.dart';

class PokemonDetailPage extends GetView<PokemonDetailController> {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const Text("Pokemon Detail",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Flexible(
              child: Container(
                color: Utils.colorByType(
                  controller.pokemonItem!.types.first!,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 150,
                      left: 50,
                      child: Image.asset(
                        "assets/images/memphis_dot.png",
                        width: 100,
                        height: 100,
                        color: Colors.white24,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -10,
                      child: Transform.rotate(
                        angle: 1.4,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -50,
                      child: Hero(
                        tag: 'ball_${controller.pokemonItem!.id}',
                        child: const WidgetLogoBackground(),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: kToolbarHeight + 30),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller
                                          .pokemonItem!.name.capitalizeFirst!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "#${controller.pokemonItem!.id}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                _typeChips(controller.pokemonItem!.types),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Hero(
                      tag: 'image_${controller.pokemonItem!.id}',
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CachedNetworkImage(
                          imageUrl:
                              '${AppConfig.baseUrlImg}${controller.pokemonItem!.id}.png',
                          height: 250.0,
                          width: 250.0,
                          errorWidget: (context, url, error) => Container(
                            color: Colors.transparent,
                          ),
                          placeholder: (context, url) => Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      indicatorColor: Utils.colorByType(
                        controller.pokemonItem!.types.first!,
                      ),
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Status'),
                        Tab(text: 'Evolution'),
                        Tab(text: 'Moves'),
                      ],
                    ),
                    Expanded(
                      child: GetX<PokemonDetailController>(
                        builder: (_) {
                          if (controller.isLoading) {
                            return SkeletonListView();
                          } else {
                            return TabBarView(
                              children: [
                                _about(),
                                _stats(),
                                _evolution(),
                                _moves(),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _about() {
    return controller.isLoading
        ? SkeletonListView()
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _WidgetStatItem(
                  label: 'Species',
                  value: controller.pokemon!.species.name.capitalizeFirst!,
                ),
                // Height in decimeter
                _WidgetStatItem(
                  label: 'Height',
                  value: "${controller.pokemon!.height * 10} Cm",
                ),
                // Height in hectogram
                _WidgetStatItem(
                  label: 'Weight',
                  value: '${controller.pokemon!.weight / 10} Kg',
                ),
                _WidgetStatItem(
                  label: 'Abilities',
                  value: controller.abilities,
                ),
              ],
            ),
          );
  }

  Widget _stats() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _WidgetStatChart(stats: controller.pokemon!.stats),
    );
  }

  Widget _evolution() {
    final second = controller.evolution!.chain.evolvesTo;
    final secondID = second!.first.species.url.split('/');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _WidgetEvolutionItem(
            name: controller.evolution!.chain.species.name,
            id: int.parse(
                controller.evolution!.chain.species.url.split('/')[6]),
            secondID: int.parse(secondID[secondID.length - 2]),
            secondName: second.first.species.name,
            level: second.first.evolutionDetails.first.minLevel,
          ),
          second.first.evolvesTo?.isNotEmpty ?? false
              ? _WidgetEvolutionItem(
                  name: second.first.species.name,
                  id: int.parse(secondID[secondID.length - 2]),
                  secondName: second.first.evolvesTo?.first.species.name ?? '-',
                  secondID: second.first.evolvesTo!.isNotEmpty
                      ? int.parse(second.first.evolvesTo!.first.species.url
                          .split('/')[second.first.evolvesTo!.first.species.url
                              .split('/')
                              .length -
                          2])
                      : null,
                  level: second.first.evolvesTo?.first.evolutionDetails.first
                          .minLevel ??
                      0,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _moves() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          children: _moveChips(controller.pokemon!.moves),
        ),
      ),
    );
  }

  List<Widget> _moveChips(List<Move> moves) {
    return moves.map<Widget>((e) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          e.name.capitalizeFirst!,
        ),
      );
    }).toList();
  }

  Widget _typeChips(List<String?> types) {
    return Flex(
      direction: Axis.horizontal,
      children: types.map((e) {
        return Container(
          margin: const EdgeInsets.only(bottom: 4, right: 4),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            e ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    );
  }
}
