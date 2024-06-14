import 'dart:convert';

class Pokemon {
  final int count;
  List<PokemonItem> results;

  Pokemon({
    required this.count,
    required this.results,
  });

  factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      count: json["count"],
      results: List<PokemonItem>.from(
        json["results"].map(
          (x) => PokemonItem.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
  }
}

class PokemonItem {
  final String id;
  final String name;
  final String url;
  List<String?> types;

  PokemonItem({
    required this.id,
    required this.name,
    required this.url,
    required this.types,
  });

  factory PokemonItem.fromRawJson(String str) =>
      PokemonItem.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokemonItem.fromJson(Map<String, dynamic> json) => PokemonItem(
        id: Uri.parse(json["url"])
            .pathSegments
            .lastWhere((segment) => segment.isNotEmpty),
        name: json["name"],
        url: json["url"],
        types: json["types"] ?? [""],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "types": types,
      };
}
