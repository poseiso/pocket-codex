import 'dart:convert';

import 'models.dart';

class Evolution {
  final dynamic babyTriggerItem;
  final Chain chain;
  final int id;

  Evolution({
    this.babyTriggerItem,
    required this.chain,
    required this.id,
  });

  factory Evolution.fromRawJson(String str) =>
      Evolution.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        babyTriggerItem: json["baby_trigger_item"],
        chain: Chain.fromJson(json["chain"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "baby_trigger_item": babyTriggerItem,
        "chain": chain.toJson(),
        "id": id,
      };
}

class Chain {
  final List<EvolutionDetail> evolutionDetails;
  final List<Chain>? evolvesTo;
  final bool isBaby;
  final Species species;

  Chain({
    required this.evolutionDetails,
    this.evolvesTo,
    required this.isBaby,
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
        isBaby: json["is_baby"],
        species: Species.fromJson(json["species"]),
      );

  Map<String, dynamic> toJson() => {
        "evolution_details":
            List<dynamic>.from(evolutionDetails.map((x) => x.toJson())),
        "evolves_to": List<dynamic>.from(evolvesTo!.map((x) => x.toJson())),
        "is_baby": isBaby,
        "species": species.toJson(),
      };
}

class EvolutionDetail {
  final dynamic gender;
  final dynamic heldItem;
  final dynamic item;
  final dynamic knownMove;
  final dynamic knownMoveType;
  final dynamic location;
  final dynamic minAffection;
  final dynamic minBeauty;
  final dynamic minHappiness;
  final dynamic minLevel;
  final bool needsOverworldRain;
  final dynamic partySpecies;
  final dynamic partyType;
  final dynamic relativePhysicalStats;
  final String timeOfDay;
  final dynamic tradeSpecies;
  final Species trigger;
  final bool turnUpsideDown;

  EvolutionDetail({
    this.gender,
    this.heldItem,
    this.item,
    this.knownMove,
    this.knownMoveType,
    this.location,
    this.minAffection,
    this.minBeauty,
    this.minHappiness,
    required this.minLevel,
    required this.needsOverworldRain,
    this.partySpecies,
    this.partyType,
    this.relativePhysicalStats,
    required this.timeOfDay,
    this.tradeSpecies,
    required this.trigger,
    required this.turnUpsideDown,
  });

  factory EvolutionDetail.fromRawJson(String str) =>
      EvolutionDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory EvolutionDetail.fromJson(Map<String, dynamic> json) =>
      EvolutionDetail(
        gender: json["gender"],
        heldItem: json["held_item"],
        item: json["item"],
        knownMove: json["known_move"],
        knownMoveType: json["known_move_type"],
        location: json["location"],
        minAffection: json["min_affection"],
        minBeauty: json["min_beauty"],
        minHappiness: json["min_happiness"],
        minLevel: json["min_level"] ?? '-',
        needsOverworldRain: json["needs_overworld_rain"],
        partySpecies: json["party_species"],
        partyType: json["party_type"],
        relativePhysicalStats: json["relative_physical_stats"],
        timeOfDay: json["time_of_day"],
        tradeSpecies: json["trade_species"],
        trigger: Species.fromJson(json["trigger"]),
        turnUpsideDown: json["turn_upside_down"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "held_item": heldItem,
        "item": item,
        "known_move": knownMove,
        "known_move_type": knownMoveType,
        "location": location,
        "min_affection": minAffection,
        "min_beauty": minBeauty,
        "min_happiness": minHappiness,
        "min_level": minLevel,
        "needs_overworld_rain": needsOverworldRain,
        "party_species": partySpecies,
        "party_type": partyType,
        "relative_physical_stats": relativePhysicalStats,
        "time_of_day": timeOfDay,
        "trade_species": tradeSpecies,
        "trigger": trigger.toJson(),
        "turn_upside_down": turnUpsideDown,
      };
}
