import 'dart:convert';

import 'models.dart';

class Evolution {
  final Chain chain;
  final int id;

  Evolution({
    required this.chain,
    required this.id,
  });

  factory Evolution.fromRawJson(String str) =>
      Evolution.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        chain: Chain.fromJson(json["chain"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "chain": chain.toJson(),
        "id": id,
      };
}

class Chain {
  final List<EvolutionDetail> evolutionDetails;
  final List<Chain>? evolvesTo;
  final Species species;

  Chain({
    required this.evolutionDetails,
    this.evolvesTo,
    required this.species,
  });

  factory Chain.fromRawJson(String str) => Chain.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chain.fromJson(Map<String, dynamic> json) => Chain(
        evolutionDetails: List<EvolutionDetail>.from(
            json["evolution_details"].map((x) => EvolutionDetail.fromJson(x))),
        evolvesTo: json["evolves_to"] == null
            ? []
            : List<Chain>.from(
                json["evolves_to"].map((x) => Chain.fromJson(x))),
        species: Species.fromJson(json["species"]),
      );

  Map<String, dynamic> toJson() => {
        "evolution_details":
            List<dynamic>.from(evolutionDetails.map((x) => x.toJson())),
        "evolves_to": List<dynamic>.from(evolvesTo!.map((x) => x.toJson())),
        "species": species.toJson(),
      };
}

class EvolutionDetail {
  final String minLevel;

  EvolutionDetail({
    required this.minLevel,
  });

  factory EvolutionDetail.fromRawJson(String str) =>
      EvolutionDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory EvolutionDetail.fromJson(Map<String, dynamic> json) =>
      EvolutionDetail(
        minLevel: json["min_level"]!=null ? json["min_level"].toString() : "-",
      );

  Map<String, dynamic> toJson() => {
        "min_level": minLevel,
      };
}
