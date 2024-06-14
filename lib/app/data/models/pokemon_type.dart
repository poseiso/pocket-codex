class PokemonType {
  final String name;
  final String url;

  PokemonType({required this.name, required this.url});

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      PokemonType(name: json["name"], url: json["url"]);

  static List<PokemonType> fromListOfJson(Map<String, dynamic> json) {
    List<PokemonType> result = [];
    for (var item in json["results"]) {
      result.add(PokemonType.fromJson(item));
    }
    return result;
  }
}
