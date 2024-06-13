import 'dart:convert';

// To avoid unnecessary indirection
// please refrain from extracting
// sub models into their own files
// they are not used anywhere else
class PokemonDetail {
  final List<Ability> abilities;
  final int height;
  final int id;
  final List<Move> moves;
  final String name;
  final Species species;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  PokemonDetail({
    required this.abilities,
    required this.height,
    required this.id,
    required this.moves,
    required this.name,
    required this.species,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory PokemonDetail.fromRawJson(String str) =>
      PokemonDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        height: json["height"],
        id: json["id"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        name: json["name"],
        species: Species.fromJson(json["species"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "height": height,
        "id": id,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "species": species.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "weight": weight,
      };
}

class Ability {
  final String name;
  final String url;

  Ability({
    required this.name,
    required this.url,
  });

  factory Ability.fromRawJson(String str) => Ability.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        name: json["ability"]["name"],
        url: json["ability"]["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Move {
  final String name;
  final String url;

  Move({
    required this.name,
    required this.url,
  });

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        name: json["move"]["name"],
        url: json["move"]["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Stat {
  final String name;
  final String url;
  final int baseStat;

  Stat({
    required this.name,
    required this.url,
    required this.baseStat,
  });

  factory Stat.fromRawJson(String str) => Stat.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        name: json["stat"]["name"],
        url: json["stat"]["url"],
        baseStat: json["base_stat"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "base_stat": baseStat,
      };
}

class Type {
  final String name;
  final String url;
  final int slot;

  Type({
    required this.name,
    required this.url,
    required this.slot,
  });

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["type"]["name"],
        url: json["type"]["url"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "slot": slot,
      };
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromRawJson(String str) => Species.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
