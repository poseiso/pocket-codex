import 'package:pocket_codex/app/data/models/models.dart';
import 'package:test/test.dart';
import 'package:get/get.dart';
import 'package:pocket_codex/app/modules/home/home.dart';
import 'package:pocket_codex/app/data/providers/providers.dart';
import 'package:pocket_codex/app/data/repositories/repositories.dart';

void main() {
  group('Home Controller', () {
    HomeController controller = HomeController(
      repository: PokemonRepository(
        provider: PokemonProvider(),
      ),
      pokemonDetailRepository: PokemonDetailRepository(
        provider: PokemonDetailProvider(),
      ),
      pokemonTypeRepository: PokemonTypeRepository(
        provider: PokemonTypeProvider(),
      ),
      pokemonTypeDetailRepository: PokemonTypeDetailRepository(
        provider: PokemonTypeDetailProvider(),
      ),
    );

    test('Initial state home controller', () {
      expect(controller.filter.value, "All Type");
      expect(controller.sort.value, "Id Ascending");
      expect(controller.sortList, [
        "Id Ascending",
        "Id Descending",
        "Name Ascending",
        "Name Descending"
      ]);
      expect(controller.pokemon, [].obs);
    });

    test('Sort pokemon Id Ascending', () {
      controller.pokemon.clear();
      controller.pokemon.value = [
        PokemonItem(id: "1", name: "Bulbasaur", url: "some url", types: []),
        PokemonItem(id: "0", name: "Diglett", url: "some url", types: [])
      ];
      controller.sort.value = "Id Ascending";
      controller.sortPokemon(controller.pokemon);
      expect(controller.pokemon.first.name, "Diglett");
    });

    test('Sort pokemon Id Descending', () {
      controller.pokemon.clear();
      controller.pokemon.value = [
        PokemonItem(id: "1", name: "Bulbasaur", url: "some url", types: []),
        PokemonItem(id: "0", name: "Diglett", url: "some url", types: [])
      ];
      controller.sort.value = "Id Descending";
      controller.sortPokemon(controller.pokemon);
      expect(controller.pokemon.first.name, "Bulbasaur");
    });


    test('Sort pokemon Name Ascending', () {
      controller.pokemon.clear();
      controller.pokemon.value = [
        PokemonItem(id: "0", name: "Diglett", url: "some url", types: []),
        PokemonItem(id: "1", name: "Bulbasaur", url: "some url", types: [])
      ];
      controller.sort.value = "Name Ascending";
      controller.sortPokemon(controller.pokemon);
      expect(controller.pokemon.first.name, "Bulbasaur");
    });

    test('Sort pokemon Name Descending', () {
      controller.pokemon.clear();
      controller.pokemon.value = [
        PokemonItem(id: "1", name: "Bulbasaur", url: "some url", types: []),
        PokemonItem(id: "0", name: "Diglett", url: "some url", types: []),
      ];
      controller.sort.value = "Name Descending";
      controller.sortPokemon(controller.pokemon);
      expect(controller.pokemon.first.name, "Diglett");
    });
  });
}
