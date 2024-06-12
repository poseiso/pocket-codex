import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_codex/app/utils/app_config.dart';
import 'package:pocket_codex/app/utils/utils.dart';

import '../../../data/models/pokemon_detail.dart';

class PokemonItem extends StatelessWidget {
  final int id;
  final String name;
  final List<Type> types;
  final Function() onTap;

  const PokemonItem({
    super.key,
    required this.id,
    required this.name,
    required this.types,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Utils.colorByType(types.first.type.name),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Stack(
            children: [
              Positioned(
                bottom: -10,
                right: -20,
                top: -10,
                child: Hero(
                  tag: 'ball_$id',
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: Colors.white24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            name.capitalizeFirst!,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _generateType(),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: CachedNetworkImage(
                        imageUrl: '${AppConfig.baseUrlImg}$id.png',
                        height: 100.0,
                        width: 100.0,
                        errorWidget: (context, url, error) => Container(
                          color: Colors.transparent,
                        ),
                        placeholder: (context, url) => Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _generateType() {
    return types.map<Widget>((e) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          e.type.name,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }).toList();
  }
}
