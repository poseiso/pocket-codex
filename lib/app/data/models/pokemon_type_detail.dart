import 'dart:convert';

import 'models.dart';

class PokemonTypeDetail {
  final String name;
  final List<PokemonItem> pokemon;

  PokemonTypeDetail({
    required this.name,
    required this.pokemon,
  });

  factory PokemonTypeDetail.fromRawJson(String str) => PokemonTypeDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokemonTypeDetail.fromJson(Map<String, dynamic> json) {
    return PokemonTypeDetail(
      name: json["name"],
      pokemon: List<PokemonItem>.from(
        json["pokemon"].map(
          (x) =>  PokemonItem.fromJson(x["pokemon"]),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "pokemon": pokemon,
    };
  }
}
