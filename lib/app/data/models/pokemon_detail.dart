import 'dart:convert';

// Many models require a structure that consists of a name and a URL.
// While some models can be straightforwardly created, such as `Species`
// which only has a name and a URL, others might be more complex and
// include such a structure as part of their properties.
//
// For example, within the `Ability` class, there might be an `Ability`
// property that is essentially just a name and a URL. In such cases,
// instead of creating separate models for each occurrence, use this
// `Resource` class to avoid redundancy and maintain consistency.
/// Generic descriptor model that contains `name` and `url`
class Desc {
  final String name;
  final String url;

  Desc({
    required this.name,
    required this.url,
  });

  factory Desc.fromRawJson(String str) => Desc.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Desc.fromJson(Map<String, dynamic> json) => Desc(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

// To avoid unnecessary indirection 
// please refrain from extracting
// sub models into their own files
// they are not used anywhere else
class PokemonDetail {
  final List<Ability> abilities;
  final int baseExperience;
  final List<Desc> forms;
  final List<GameIndex> gameIndices;
  final int height;
  final List<HeldItem> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final List<dynamic> pastTypes;
  final Species species;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  PokemonDetail({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory PokemonDetail.fromRawJson(String str) =>
      PokemonDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        abilities: List<Ability>.from(
          json["abilities"].map((x) => Ability.fromJson(x)),
        ),
        baseExperience: json["base_experience"],
        forms: List<Desc>.from(
          json["forms"].map((x) => Desc.fromJson(x)),
        ),
        gameIndices: List<GameIndex>.from(
          json["game_indices"].map((x) => GameIndex.fromJson(x)),
        ),
        height: json["height"],
        heldItems: List<HeldItem>.from(
          json["held_items"].map((x) => HeldItem.fromJson(x)),
        ),
        id: json["id"],
        isDefault: json["is_default"],
        locationAreaEncounters: json["location_area_encounters"],
        moves: List<Move>.from(
          json["moves"].map((x) => Move.fromJson(x)),
        ),
        name: json["name"],
        order: json["order"],
        pastTypes: List<dynamic>.from(json["past_types"].map((x) => x)),
        species: Species.fromJson(json["species"]),
        sprites: Sprites.fromJson(json["sprites"]),
        stats: List<Stat>.from(
          json["stats"].map((x) => Stat.fromJson(x)),
        ),
        types: List<Type>.from(
          json["types"].map((x) => Type.fromJson(x)),
        ),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "base_experience": baseExperience,
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
        "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
        "height": height,
        "held_items": List<dynamic>.from(heldItems.map((x) => x.toJson())),
        "id": id,
        "is_default": isDefault,
        "location_area_encounters": locationAreaEncounters,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "order": order,
        "past_types": List<dynamic>.from(pastTypes.map((x) => x)),
        "species": species.toJson(),
        "sprites": sprites.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "weight": weight,
      };
}

class Ability {
  final Desc ability;
  final bool isHidden;
  final int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromRawJson(String str) => Ability.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: Desc.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class GameIndex {
  final int gameIndex;
  final Desc version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromRawJson(String str) =>
      GameIndex.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"],
        version: Desc.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "game_index": gameIndex,
        "version": version.toJson(),
      };
}

class HeldItem {
  final Desc item;
  final List<VersionDetail> versionDetails;

  HeldItem({
    required this.item,
    required this.versionDetails,
  });

  factory HeldItem.fromRawJson(String str) =>
      HeldItem.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory HeldItem.fromJson(Map<String, dynamic> json) => HeldItem(
        item: Desc.fromJson(json["item"]),
        versionDetails: List<VersionDetail>.from(
            json["version_details"].map((x) => VersionDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "version_details":
            List<dynamic>.from(versionDetails.map((x) => x.toJson())),
      };
}

class VersionDetail {
  final int rarity;
  final Desc version;

  VersionDetail({
    required this.rarity,
    required this.version,
  });

  factory VersionDetail.fromRawJson(String str) =>
      VersionDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory VersionDetail.fromJson(Map<String, dynamic> json) => VersionDetail(
        rarity: json["rarity"],
        version: Desc.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "rarity": rarity,
        "version": version.toJson(),
      };
}

class Move {
  final Desc move;
  final List<VersionGroupDetail> versionGroupDetails;
  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: Desc.fromJson(json["move"]),
        versionGroupDetails: List<VersionGroupDetail>.from(
            json["version_group_details"]
                .map((x) => VersionGroupDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "move": move.toJson(),
        "version_group_details":
            List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
      };
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final Desc moveLearnMethod;
  final Desc versionGroup;
  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromRawJson(String str) =>
      VersionGroupDetail.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: Desc.fromJson(json["move_learn_method"]),
        versionGroup: Desc.fromJson(json["version_group"]),
      );

  Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method": moveLearnMethod.toJson(),
        "version_group": versionGroup.toJson(),
      };
}

class GenerationV {
  final Sprites blackWhite;
  GenerationV({
    required this.blackWhite,
  });

  factory GenerationV.fromRawJson(String str) =>
      GenerationV.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationV.fromJson(Map<String, dynamic> json) => GenerationV(
        blackWhite: Sprites.fromJson(json["black-white"]),
      );

  Map<String, dynamic> toJson() => {
        "black-white": blackWhite.toJson(),
      };
}

class GenerationIv {
  final Sprites diamondPearl;
  final Sprites heartgoldSoulsilver;
  final Sprites platinum;

  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  factory GenerationIv.fromRawJson(String str) =>
      GenerationIv.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationIv.fromJson(Map<String, dynamic> json) => GenerationIv(
        diamondPearl: Sprites.fromJson(json["diamond-pearl"]),
        heartgoldSoulsilver: Sprites.fromJson(json["heartgold-soulsilver"]),
        platinum: Sprites.fromJson(json["platinum"]),
      );

  Map<String, dynamic> toJson() => {
        "diamond-pearl": diamondPearl.toJson(),
        "heartgold-soulsilver": heartgoldSoulsilver.toJson(),
        "platinum": platinum.toJson(),
      };
}

class Versions {
  final GenerationI generationI;
  final GenerationIi generationIi;
  final GenerationIii generationIii;
  final GenerationIv generationIv;
  final GenerationV generationV;
  final GenerationVi generationVi;
  final GenerationVii generationVii;
  final GenerationViii generationViii;

  Versions({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  factory Versions.fromRawJson(String str) =>
      Versions.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        generationI: GenerationI.fromJson(json["generation-i"]),
        generationIi: GenerationIi.fromJson(json["generation-ii"]),
        generationIii: GenerationIii.fromJson(json["generation-iii"]),
        generationIv: GenerationIv.fromJson(json["generation-iv"]),
        generationV: GenerationV.fromJson(json["generation-v"]),
        generationVi: GenerationVi.fromJson(json["generation-vi"]),
        generationVii: GenerationVii.fromJson(json["generation-vii"]),
        generationViii: GenerationViii.fromJson(json["generation-viii"]),
      );

  Map<String, dynamic> toJson() => {
        "generation-i": generationI.toJson(),
        "generation-ii": generationIi.toJson(),
        "generation-iii": generationIii.toJson(),
        "generation-iv": generationIv.toJson(),
        "generation-v": generationV.toJson(),
        "generation-vi": generationVi.toJson(),
        "generation-vii": generationVii.toJson(),
        "generation-viii": generationViii.toJson(),
      };
}

class Sprites {
  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;
  Other? other;
  Versions? versions;
  Sprites? animated;

  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
    this.versions,
    this.animated,
  });

  factory Sprites.fromRawJson(String str) => Sprites.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        versions: json["versions"] == null
            ? null
            : Versions.fromJson(json["versions"]),
        animated: json["animated"] == null
            ? null
            : Sprites.fromJson(json["animated"]),
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
        'other': other?.toJson(),
        'versions': versions?.toJson(),
        'animated': animated?.toJson(),
      };
}

class GenerationI {
  final RedBlue redBlue;
  final RedBlue yellow;

  GenerationI({
    required this.redBlue,
    required this.yellow,
  });

  factory GenerationI.fromRawJson(String str) =>
      GenerationI.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationI.fromJson(Map<String, dynamic> json) => GenerationI(
        redBlue: RedBlue.fromJson(json["red-blue"]),
        yellow: RedBlue.fromJson(json["yellow"]),
      );

  Map<String, dynamic> toJson() => {
        "red-blue": redBlue.toJson(),
        "yellow": yellow.toJson(),
      };
}

class RedBlue {
  final String backDefault;
  final String backGray;
  final String frontDefault;
  final String frontGray;

  RedBlue({
    required this.backDefault,
    required this.backGray,
    required this.frontDefault,
    required this.frontGray,
  });

  factory RedBlue.fromRawJson(String str) => RedBlue.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory RedBlue.fromJson(Map<String, dynamic> json) => RedBlue(
        backDefault: json["back_default"],
        backGray: json["back_gray"],
        frontDefault: json["front_default"],
        frontGray: json["front_gray"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_gray": backGray,
        "front_default": frontDefault,
        "front_gray": frontGray,
      };
}

class GenerationIi {
  final Crystal crystal;
  final Crystal gold;
  final Crystal silver;

  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  factory GenerationIi.fromRawJson(String str) =>
      GenerationIi.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationIi.fromJson(Map<String, dynamic> json) => GenerationIi(
        crystal: Crystal.fromJson(json["crystal"]),
        gold: Crystal.fromJson(json["gold"]),
        silver: Crystal.fromJson(json["silver"]),
      );

  Map<String, dynamic> toJson() => {
        "crystal": crystal.toJson(),
        "gold": gold.toJson(),
        "silver": silver.toJson(),
      };
}

class Crystal {
  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;

  Crystal({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
  });

  factory Crystal.fromRawJson(String str) => Crystal.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Crystal.fromJson(Map<String, dynamic> json) => Crystal(
        backDefault: json["back_default"],
        backShiny: json["back_shiny"],
        frontDefault: json["front_default"],
        frontShiny: json["front_shiny"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_shiny": backShiny,
        "front_default": frontDefault,
        "front_shiny": frontShiny,
      };
}

class GenerationIii {
  final Emerald emerald;
  final Crystal fireredLeafgreen;
  final Crystal rubySapphire;

  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  factory GenerationIii.fromRawJson(String str) =>
      GenerationIii.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationIii.fromJson(Map<String, dynamic> json) => GenerationIii(
        emerald: Emerald.fromJson(json["emerald"]),
        fireredLeafgreen: Crystal.fromJson(json["firered-leafgreen"]),
        rubySapphire: Crystal.fromJson(json["ruby-sapphire"]),
      );

  Map<String, dynamic> toJson() => {
        "emerald": emerald.toJson(),
        "firered-leafgreen": fireredLeafgreen.toJson(),
        "ruby-sapphire": rubySapphire.toJson(),
      };
}

class Emerald {
  final String frontDefault;
  final String frontShiny;

  Emerald({
    required this.frontDefault,
    required this.frontShiny,
  });

  factory Emerald.fromRawJson(String str) => Emerald.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Emerald.fromJson(Map<String, dynamic> json) => Emerald(
        frontDefault: json["front_default"],
        frontShiny: json["front_shiny"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_shiny": frontShiny,
      };
}

class GenerationVi {
  final OmegarubyAlphasapphire omegarubyAlphasapphire;
  final OmegarubyAlphasapphire xY;

  GenerationVi({
    required this.omegarubyAlphasapphire,
    required this.xY,
  });

  factory GenerationVi.fromRawJson(String str) =>
      GenerationVi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenerationVi.fromJson(Map<String, dynamic> json) => GenerationVi(
        omegarubyAlphasapphire:
            OmegarubyAlphasapphire.fromJson(json["omegaruby-alphasapphire"]),
        xY: OmegarubyAlphasapphire.fromJson(json["x-y"]),
      );

  Map<String, dynamic> toJson() => {
        "omegaruby-alphasapphire": omegarubyAlphasapphire.toJson(),
        "x-y": xY.toJson(),
      };
}

class OmegarubyAlphasapphire {
  final String frontDefault;
  String? frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;

  OmegarubyAlphasapphire({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    this.frontShinyFemale,
  });

  factory OmegarubyAlphasapphire.fromRawJson(String str) =>
      OmegarubyAlphasapphire.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory OmegarubyAlphasapphire.fromJson(Map<String, dynamic> json) =>
      OmegarubyAlphasapphire(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class GenerationVii {
  final DreamWorld icons;
  final OmegarubyAlphasapphire ultraSunUltraMoon;

  GenerationVii({
    required this.icons,
    required this.ultraSunUltraMoon,
  });

  factory GenerationVii.fromRawJson(String str) =>
      GenerationVii.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationVii.fromJson(Map<String, dynamic> json) => GenerationVii(
        icons: DreamWorld.fromJson(json["icons"]),
        ultraSunUltraMoon:
            OmegarubyAlphasapphire.fromJson(json["ultra-sun-ultra-moon"]),
      );

  Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
        "ultra-sun-ultra-moon": ultraSunUltraMoon.toJson(),
      };
}

class DreamWorld {
  final String frontDefault;
  final String? frontFemale;

  DreamWorld({
    required this.frontDefault,
    this.frontFemale,
  });

  factory DreamWorld.fromRawJson(String str) =>
      DreamWorld.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory DreamWorld.fromJson(Map<String, dynamic> json) => DreamWorld(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
      };
}

class GenerationViii {
  final DreamWorld icons;

  GenerationViii({
    required this.icons,
  });

  factory GenerationViii.fromRawJson(String str) =>
      GenerationViii.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GenerationViii.fromJson(Map<String, dynamic> json) => GenerationViii(
        icons: DreamWorld.fromJson(json["icons"]),
      );

  Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
      };
}

class Other {
  final DreamWorld dreamWorld;
  final OfficialArtwork officialArtwork;

  Other({
    required this.dreamWorld,
    required this.officialArtwork,
  });

  factory Other.fromRawJson(String str) => Other.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        dreamWorld: DreamWorld.fromJson(json["dream_world"]),
        officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
      );

  Map<String, dynamic> toJson() => {
        "dream_world": dreamWorld.toJson(),
        "official-artwork": officialArtwork.toJson(),
      };
}

class OfficialArtwork {
  final String frontDefault;

  OfficialArtwork({
    required this.frontDefault,
  });

  factory OfficialArtwork.fromRawJson(String str) =>
      OfficialArtwork.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      OfficialArtwork(
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
      };
}

class Stat {
  final int baseStat;
  final int effort;
  final Desc stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromRawJson(String str) => Stat.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Desc.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

class Type {
  final int slot;
  final Desc type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Desc.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
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
