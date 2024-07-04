import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pocket_codex/app/data/models/models.dart';
import 'package:pocket_codex/app/data/repositories/repositories.dart';
import 'package:pocket_codex/app/modules/home/home.dart';
import 'package:test/test.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([
  PokemonRepository,
  PokemonTypeRepository,
  PokemonTypeDetailRepository,
  PokemonDetailRepository,
  HomeController
])
void main() {
  late HomeController controller;
  late MockPokemonRepository mockPokemonRepository;
  late MockPokemonTypeRepository mockPokemonTypeRepository;
  late MockPokemonTypeDetailRepository mockPokemonTypeDetailRepository;
  late MockPokemonDetailRepository mockPokemonDetailRepository;

  Logger.level = Level.fatal;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    mockPokemonTypeRepository = MockPokemonTypeRepository();
    mockPokemonTypeDetailRepository = MockPokemonTypeDetailRepository();
    mockPokemonDetailRepository = MockPokemonDetailRepository();
    controller = HomeController(
      repository: mockPokemonRepository,
      pokemonTypeRepository: mockPokemonTypeRepository,
      pokemonTypeDetailRepository: mockPokemonTypeDetailRepository,
      pokemonDetailRepository: mockPokemonDetailRepository,
    );
  });

  tearDown(() {
    Get.reset();
  });

  test('Initial values are correct', () {
    expect(controller.pokemon.isEmpty, true);
    expect(controller.filter.value, 'All Type');
    expect(controller.sort.value, 'Id Ascending');
    expect(controller.pokemonTypes.first.name, 'All Type');
  });

  test('Controller on init', () async {
    final mockPokemonList = Future.value(
      Pokemon(
          count: 50,
          results: List.generate(
            50,
            (index) => PokemonItem(
              name: 'Pokemon$index',
              url: '',
              id: '$index',
              types: [],
            ),
          )),
    );
    final mockTypeList = Future.value([
      PokemonType(name: "normal", url: ""),
      PokemonType(name: "normal", url: ""),
      PokemonType(name: "normal", url: ""),
    ]);
    when(mockPokemonRepository.fetchPokemon(any, any))
        .thenAnswer((_) async => mockPokemonList);
    when(mockPokemonTypeRepository.fetchPokemonType(any, any))
        .thenAnswer((_) async => mockTypeList);

    Get.put(controller);

    verify(mockPokemonRepository.fetchPokemon(any, any)).called(1);
    verify(mockPokemonTypeRepository.fetchPokemonType(any, any)).called(1);

    Get.delete<HomeController>();
  });

  group('Fetch all type', () {
    test('Fetch all type success', () async {
      final mockTypeList = Future.value([
        PokemonType(name: "normal", url: ""),
        PokemonType(name: "normal", url: ""),
        PokemonType(name: "normal", url: ""),
      ]);

      when(mockPokemonTypeRepository.fetchPokemonType(any, any))
          .thenAnswer((_) async => mockTypeList);

      await controller.fetchAllType();

      for (var i = 1; i < controller.pokemonTypes.length; i++) {
        expect(controller.pokemonTypes[i].name, 'normal');
      }
      verify(mockPokemonTypeRepository.fetchPokemonType(any, any)).called(1);
    });

    test('Fetch all type null', () async {
      when(mockPokemonTypeRepository.fetchPokemonType(any, any))
          .thenAnswer((_) async => null);

      await controller.fetchAllType();

      expect(controller.pokemonTypes.length, 1);
      expect(controller.state, null);
      expect(controller.status.isError, true);
      verify(mockPokemonTypeRepository.fetchPokemonType(any, any)).called(1);
    });
  });

  group('Fetch all pokemon', () {
    test('Fetch all Pokemon success', () async {
      final mockPokemonList = Future.value(
        Pokemon(
            count: 50,
            results: List.generate(
              50,
              (index) => PokemonItem(
                name: 'Pokemon$index',
                url: '',
                id: '$index',
                types: [],
              ),
            )),
      );
      final mockPokemonDetail = Future.value(
        PokemonDetail(
            abilities: [],
            height: 1,
            id: 0,
            moves: [],
            name: 'Pokemon0',
            species: Species(name: "Pokemon", url: ""),
            stats: [],
            types: [Type(name: "Normal", url: "", slot: 1)],
            weight: 10),
      );

      when(mockPokemonRepository.fetchPokemon(any, any))
          .thenAnswer((_) async => mockPokemonList);
      when(mockPokemonDetailRepository.fetchPokemonDetail(any))
          .thenAnswer((_) async => mockPokemonDetail);

      await controller.fetchAllPokemon();
      expect(controller.pokemon.length, 50);
      expect(controller.pokemon.first.types.first, "Normal");
      verify(mockPokemonRepository.fetchPokemon(any, any)).called(1);
    });

    test('Fetch all Pokemon success with empty type', () async {
      final mockPokemonList = Future.value(
        Pokemon(
            count: 50,
            results: List.generate(
              50,
              (index) => PokemonItem(
                name: 'Pokemon$index',
                url: '',
                id: '$index',
                types: [],
              ),
            )),
      );
      final mockPokemonDetail = Future.value(
        PokemonDetail(
            abilities: [],
            height: 1,
            id: 0,
            moves: [],
            name: 'Pokemon0',
            species: Species(name: "Pokemon", url: ""),
            stats: [],
            types: [],
            weight: 10),
      );
      when(mockPokemonRepository.fetchPokemon(any, any))
          .thenAnswer((_) async => mockPokemonList);
      when(mockPokemonDetailRepository.fetchPokemonDetail(any))
          .thenAnswer((_) async => mockPokemonDetail);

      await controller.fetchAllPokemon();

      verify(mockPokemonRepository.fetchPokemon(any, any)).called(1);
    });

    test('Fetch all Pokemon null', () async {
      when(mockPokemonRepository.fetchPokemon(any, any))
          .thenAnswer((_) async => null);

      await controller.fetchAllPokemon();

      expect(controller.pokemon.length, 0);
      expect(controller.state, null);
      expect(controller.status.isError, true);
      verify(mockPokemonRepository.fetchPokemon(any, any)).called(1);
    });
  });

  group('Fetch pokemon by type', () {
    test('test name', () async {
      final mockPokemonDetail =
          Future.value(PokemonTypeDetail(name: 'Fire', pokemon: [
        PokemonItem(id: '1', name: 'Charmander', url: '', types: ["Fire"]),
        PokemonItem(id: '1', name: 'Charmeleion', url: '', types: ["Fire"]),
        PokemonItem(
            id: '1', name: 'Charizard', url: '', types: ["Fire", "Flying"]),
      ]));
      when(mockPokemonTypeDetailRepository.fetchPokemonType(any))
          .thenAnswer((_) async => mockPokemonDetail);

      await controller.fetchPokemonByType();
    });
  });

  group('PokemonController onChangeFilter', () {
    test('should set filter value', () async {
      controller.onChangeFilter("Fire");
      expect(controller.filter.value, "Fire");
    });

    test('should fetch all pokemon if filter is "All Type"', () async {
      controller.onChangeFilter("All Type");
      verify(controller.fetchAllPokemon()).called(1);
      verifyNever(controller.fetchPokemonByType());
    });

    test('should fetch pokemon by type if filter is not "All Type"', () async {
      controller.onChangeFilter("Fire");
      verify(controller.fetchPokemonByType()).called(1);
      verifyNever(controller.fetchAllPokemon());
    });
  });

  group('Pokemon sort', () {
    final list = [
      PokemonItem(id: '3', name: 'Bulbasaur', url: "", types: []),
      PokemonItem(id: '1', name: 'Charmander', url: '', types: []),
      PokemonItem(id: '2', name: 'Squirtle', url: '', types: []),
    ];
    test('should sort by Id Ascending', () {
      controller.sort.value = "Id Ascending";
      controller.sortPokemon(list);
      expect(list.map((e) => e.id), ['1', '2', '3']);
    });

    test('should sort by Id Descending', () {
      controller.sort.value = "Id Descending";
      controller.sortPokemon(list);
      expect(list.map((e) => e.id), ['3', '2', '1']);
    });

    test('should sort by Name Ascending', () {
      controller.sort.value = "Name Ascending";
      controller.sortPokemon(list);
      expect(list.map((e) => e.name), ['Bulbasaur', 'Charmander', 'Squirtle']);
    });

    test('should sort by Name Descending', () {
      controller.sort.value = "Name Descending";
      controller.sortPokemon(list);
      expect(list.map((e) => e.name), ['Squirtle', 'Charmander', 'Bulbasaur']);
    });

    test('should sort by default', () {
      controller.sort.value = "Outside of case";
      controller.sortPokemon(list);
      expect(list.map((e) => e.name), ['Bulbasaur', 'Charmander', 'Squirtle']);
    });
  });

  group('Pokemon on short change', () {
    test('should set sort value', () async {
      controller.onChangeSort("Name Ascending");
      expect(controller.sort.value, "Name Ascending");
    });

    test('should fetch all if sort value changes and filter is "All Type"',
        () async {
      controller.onChangeSort("All Type");
      verify(mockPokemonRepository.fetchPokemon(any, any)).called(1);
    });

    test(
        'should fetch details if sort value changes and filter is not "All Type"',
        () async {
      when(mockPokemonDetailRepository.fetchPokemonDetail(any))
          .thenAnswer((_) async => null);
      controller.filter.value = "Fire";
      controller.pokemon.value = [
        PokemonItem(id: "Test", name: "Test", url: "", types: []),
        PokemonItem(id: "Test", name: "Test", url: "", types: []),
      ];
      controller.onChangeSort("Name Descending");
      verify(mockPokemonDetailRepository.fetchPokemonDetail(any)).called(2);
    });
  });
}
