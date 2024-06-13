import 'dart:convert';

// To avoid unnecessary indirection
// please refrain from extracting
// sub models into their own files
// they are not used anywhere else
class PokemonSpecies {
  final EvolutionChain evolutionChain;
  final int id;
  final String name;

  PokemonSpecies({
    required this.evolutionChain,
    required this.id,
    required this.name,
  });

  factory PokemonSpecies.fromRawJson(String str) =>
      PokemonSpecies.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        evolutionChain: EvolutionChain.fromJson(json["evolution_chain"]),
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "evolution_chain": evolutionChain.toJson(),
        "id": id,
        "name": name,
      };
}

class EvolutionChain {
  final String url;

  EvolutionChain({
    required this.url,
  });

  factory EvolutionChain.fromRawJson(String str) =>
      EvolutionChain.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
