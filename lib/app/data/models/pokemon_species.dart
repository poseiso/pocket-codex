import 'dart:convert';

// To avoid unnecessary indirection
// please refrain from extracting
// sub models into their own files
// they are not used anywhere else
class PokemonSpecies {
  final int baseHappiness;
  final int captureRate;
  final PokemonColor color;
  final List<EggGroup> eggGroups;
  final EvolutionChain evolutionChain;
  final EvolvesFromSpecies? evolvesFromSpecies;
  final List<FlavorTextEntry> flavorTextEntries;
  final List<dynamic> formDescriptions;
  final bool formsSwitchable;
  final int genderRate;
  final List<Genus> genera;
  final Generation generation;
  final GrowthRate growthRate;
  final Habitat habitat;
  final bool hasGenderDifferences;
  final int hatchCounter;
  final int id;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String name;
  final List<Name> names;
  final int order;
  final List<PalParkEncounter> palParkEncounters;
  final List<PokedexNumber> pokedexNumbers;
  final Shape shape;
  final List<Variety> varieties;

  PokemonSpecies({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.eggGroups,
    required this.evolutionChain,
    this.evolvesFromSpecies,
    required this.flavorTextEntries,
    required this.formDescriptions,
    required this.formsSwitchable,
    required this.genderRate,
    required this.genera,
    required this.generation,
    required this.growthRate,
    required this.habitat,
    required this.hasGenderDifferences,
    required this.hatchCounter,
    required this.id,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.name,
    required this.names,
    required this.order,
    required this.palParkEncounters,
    required this.pokedexNumbers,
    required this.shape,
    required this.varieties,
  });

  factory PokemonSpecies.fromRawJson(String str) =>
      PokemonSpecies.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        baseHappiness: json["base_happiness"],
        captureRate: json["capture_rate"],
        color: PokemonColor.fromJson(json["color"]),
        eggGroups: List<EggGroup>.from(
            json["egg_groups"].map((x) => EggGroup.fromJson(x))),
        evolutionChain: EvolutionChain.fromJson(json["evolution_chain"]),
        evolvesFromSpecies: json["evolves_from_species"] == null
            ? null
            : EvolvesFromSpecies.fromJson(json["evolves_from_species"]),
        flavorTextEntries: List<FlavorTextEntry>.from(
            json["flavor_text_entries"]
                .map((x) => FlavorTextEntry.fromJson(x))),
        formDescriptions:
            List<dynamic>.from(json["form_descriptions"].map((x) => x)),
        formsSwitchable: json["forms_switchable"],
        genderRate: json["gender_rate"],
        genera: List<Genus>.from(json["genera"].map((x) => Genus.fromJson(x))),
        generation: Generation.fromJson(json["generation"]),
        growthRate: GrowthRate.fromJson(json["growth_rate"]),
        habitat: Habitat.fromJson(json["habitat"]),
        hasGenderDifferences: json["has_gender_differences"],
        hatchCounter: json["hatch_counter"],
        id: json["id"],
        isBaby: json["is_baby"],
        isLegendary: json["is_legendary"],
        isMythical: json["is_mythical"],
        name: json["name"],
        names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        order: json["order"],
        palParkEncounters: List<PalParkEncounter>.from(
            json["pal_park_encounters"]
                .map((x) => PalParkEncounter.fromJson(x))),
        pokedexNumbers: List<PokedexNumber>.from(
            json["pokedex_numbers"].map((x) => PokedexNumber.fromJson(x))),
        shape: Shape.fromJson(json["shape"]),
        varieties: List<Variety>.from(
            json["varieties"].map((x) => Variety.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "base_happiness": baseHappiness,
        "capture_rate": captureRate,
        "color": color.toJson(),
        "egg_groups": List<dynamic>.from(eggGroups.map((x) => x.toJson())),
        "evolution_chain": evolutionChain.toJson(),
        "evolves_from_species": evolvesFromSpecies!.toJson(),
        "flavor_text_entries":
            List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
        "form_descriptions": List<dynamic>.from(formDescriptions.map((x) => x)),
        "forms_switchable": formsSwitchable,
        "gender_rate": genderRate,
        "genera": List<dynamic>.from(genera.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "growth_rate": growthRate.toJson(),
        "habitat": habitat.toJson(),
        "has_gender_differences": hasGenderDifferences,
        "hatch_counter": hatchCounter,
        "id": id,
        "is_baby": isBaby,
        "is_legendary": isLegendary,
        "is_mythical": isMythical,
        "name": name,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
        "order": order,
        "pal_park_encounters":
            List<dynamic>.from(palParkEncounters.map((x) => x.toJson())),
        "pokedex_numbers":
            List<dynamic>.from(pokedexNumbers.map((x) => x.toJson())),
        "shape": shape.toJson(),
        "varieties": List<dynamic>.from(varieties.map((x) => x.toJson())),
      };
}

class PokemonColor {
  final String name;
  final String url;

  PokemonColor({
    required this.name,
    required this.url,
  });

  factory PokemonColor.fromRawJson(String str) =>
      PokemonColor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokemonColor.fromJson(Map<String, dynamic> json) => PokemonColor(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
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

class FlavorTextEntry {
  final String flavorText;
  final PokemonColor language;
  final PokemonColor version;

  FlavorTextEntry({
    required this.flavorText,
    required this.language,
    required this.version,
  });

  factory FlavorTextEntry.fromRawJson(String str) =>
      FlavorTextEntry.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) =>
      FlavorTextEntry(
        flavorText: json["flavor_text"],
        language: PokemonColor.fromJson(json["language"]),
        version: PokemonColor.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "flavor_text": flavorText,
        "language": language.toJson(),
        "version": version.toJson(),
      };
}

class Genus {
  final String genus;
  final PokemonColor language;

  Genus({
    required this.genus,
    required this.language,
  });

  factory Genus.fromRawJson(String str) => Genus.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Genus.fromJson(Map<String, dynamic> json) => Genus(
        genus: json["genus"],
        language: PokemonColor.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "genus": genus,
        "language": language.toJson(),
      };
}

class Name {
  final PokemonColor language;
  final String name;

  Name({
    required this.language,
    required this.name,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        language: PokemonColor.fromJson(json["language"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language.toJson(),
        "name": name,
      };
}

class PalParkEncounter {
  final PokemonColor area;
  final int baseScore;
  final int rate;

  PalParkEncounter({
    required this.area,
    required this.baseScore,
    required this.rate,
  });

  factory PalParkEncounter.fromRawJson(String str) =>
      PalParkEncounter.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PalParkEncounter.fromJson(Map<String, dynamic> json) =>
      PalParkEncounter(
        area: PokemonColor.fromJson(json["area"]),
        baseScore: json["base_score"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "area": area.toJson(),
        "base_score": baseScore,
        "rate": rate,
      };
}

class PokedexNumber {
  final int entryNumber;
  final PokemonColor pokedex;

  PokedexNumber({
    required this.entryNumber,
    required this.pokedex,
  });

  factory PokedexNumber.fromRawJson(String str) =>
      PokedexNumber.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokedexNumber.fromJson(Map<String, dynamic> json) => PokedexNumber(
        entryNumber: json["entry_number"],
        pokedex: PokemonColor.fromJson(json["pokedex"]),
      );

  Map<String, dynamic> toJson() => {
        "entry_number": entryNumber,
        "pokedex": pokedex.toJson(),
      };
}

class Variety {
  final bool isDefault;
  final PokemonColor pokemon;

  Variety({
    required this.isDefault,
    required this.pokemon,
  });

  factory Variety.fromRawJson(String str) => Variety.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Variety.fromJson(Map<String, dynamic> json) => Variety(
        isDefault: json["is_default"],
        pokemon: PokemonColor.fromJson(json["pokemon"]),
      );

  Map<String, dynamic> toJson() => {
        "is_default": isDefault,
        "pokemon": pokemon.toJson(),
      };
}

class EggGroup {
  final String name;
  final String url;

  EggGroup({
    required this.name,
    required this.url,
  });

  factory EggGroup.fromRawJson(String str) =>
      EggGroup.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory EggGroup.fromJson(Map<String, dynamic> json) => EggGroup(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class EvolvesFromSpecies {
  final String name;
  final String url;

  EvolvesFromSpecies({
    required this.name,
    required this.url,
  });

  factory EvolvesFromSpecies.fromRawJson(String str) =>
      EvolvesFromSpecies.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory EvolvesFromSpecies.fromJson(Map<String, dynamic> json) =>
      EvolvesFromSpecies(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Generation {
  final String name;
  final String url;

  Generation({
    required this.name,
    required this.url,
  });

  factory Generation.fromRawJson(String str) =>
      Generation.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class GrowthRate {
  final String name;
  final String url;

  GrowthRate({
    required this.name,
    required this.url,
  });

  factory GrowthRate.fromRawJson(String str) =>
      GrowthRate.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GrowthRate.fromJson(Map<String, dynamic> json) => GrowthRate(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Habitat {
  final String name;
  final String url;

  Habitat({
    required this.name,
    required this.url,
  });

  factory Habitat.fromRawJson(String str) => Habitat.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Habitat.fromJson(Map<String, dynamic> json) => Habitat(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Shape {
  final String name;
  final String url;

  Shape({
    required this.name,
    required this.url,
  });

  factory Shape.fromRawJson(String str) => Shape.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Shape.fromJson(Map<String, dynamic> json) => Shape(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
