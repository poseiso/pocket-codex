import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pocket_codex/app/common/widget_error.dart';
import 'package:pocket_codex/app/common/widget_loading.dart';
import 'package:pocket_codex/app/data/models/models.dart';
import 'package:pocket_codex/app/modules/home/home_controller.dart';
import 'package:pocket_codex/app/modules/home/home_page.dart';
import 'package:pocket_codex/app/modules/home/widgets/pokemon_item.dart';
import 'package:mockito/mockito.dart';

import '../unit/home/home_controller_test.mocks.dart';

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

  testWidgets('HomePage displays correctly', (WidgetTester tester) async {
    final mockTypeList = Future.value([
      PokemonType(name: "normal", url: ""),
      PokemonType(name: "normal", url: ""),
      PokemonType(name: "normal", url: ""),
    ]);
    when(mockPokemonTypeRepository.fetchPokemonType(any, any))
        .thenAnswer((_) async => mockTypeList);
    Get.put<HomeController>(controller);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: HomePage(),
      ),
    );

    expect(find.text('Pokedex'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsNWidgets(2));
  });

  testWidgets('HomePage displays loading state', (WidgetTester tester) async {
    // Arrange
    final mockTypeList = Future.value([
      PokemonType(name: "normal", url: ""),
      PokemonType(name: "normal", url: ""),
      PokemonType(name: "normal", url: ""),
    ]);
    when(mockPokemonTypeRepository.fetchPokemonType(any, any))
        .thenAnswer((_) async => mockTypeList);

    Get.put<HomeController>(controller);

    // Act
    await tester.pumpWidget(
      const GetMaterialApp(
        home: HomePage(),
      ),
    );

    // Assert
    expect(find.byType(LoadingLogo), findsOneWidget);
  });

  testWidgets('HomePage displays error state', (WidgetTester tester) async {
    // Arrange
    when(mockPokemonRepository.fetchPokemon(any, any))
        .thenAnswer((_) async => null);
    when(mockPokemonDetailRepository.fetchPokemonDetail(any))
        .thenAnswer((_) async => null);
    when(mockPokemonTypeRepository.fetchPokemonType(any, any))
        .thenAnswer((_) async => null);
    Get.put<HomeController>(controller);

    // Act
    await tester.pumpWidget(
      const GetMaterialApp(
        home: HomePage(),
      ),
    );

    // Assert
    expect(find.byType(WidgetError), findsOneWidget);
  });

  testWidgets('HomePage displays pokemon items', (WidgetTester tester) async {
    // Arrange
    final mockPokemonList = Future.value(
      Pokemon(
          count: 2,
          results: List.generate(
            2,
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
    Get.put<HomeController>(controller);

    // Act
    await tester.pumpWidget(
      const GetMaterialApp(
        home: HomePage(),
      ),
    );

    // Assert
    expect(find.byType(PokemonItemWidget), findsNWidgets(2));
    expect(find.text('Pokemon0'), findsOneWidget);
    expect(find.text('Pokemon1'), findsOneWidget);
  });
}
