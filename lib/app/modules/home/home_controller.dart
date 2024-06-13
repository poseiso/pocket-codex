import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class HomeController extends GetxController with StateMixin<List<PokemonItem>> {
  final PokemonRepository _repository;
  final PokemonDetailRepository _pokemonDetailRepository;
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;

  HomeController({
    required PokemonRepository repository,
    required PokemonDetailRepository pokemonDetailRepository,
  })  : _repository = repository,
        _pokemonDetailRepository = pokemonDetailRepository;

  final _offset = 0.obs;
  final _pokemon = <PokemonItem>[].obs;

  int get offset => _offset.value;
  ScrollController get scrollController => _scrollController;

  @override
  Future onInit() async {
    fetchAllPokemon();
    _scrollController.addListener(() {
      if (scrollController.position.pixels >
              scrollController.position.maxScrollExtent &&
          !_isFetching) {
        _offset.value += 50;
        fetchAllPokemon();
      }
    });
    super.onInit();
  }

  /// Due to the structure of the API,
  /// we will first fetch only the Pokemon names
  /// to quickly display them to the user.
  /// Additional information is available on another route
  /// but is expensive to fetch, as it requires a GET request for each item.
  /// Therefore, the details will be fetched afterward.
  Future<void> fetchAllPokemon() async {
    if (_offset.value == 0) {
      change(null, status: RxStatus.loading());
    }
    try {
      _isFetching = true;
      final pokemonResponse = await _repository.fetchPokemon(_offset.value, 50);
      if (pokemonResponse == null) {
        throw Exception("No result from fetch");
      }
      _pokemon.value = [..._pokemon, ...pokemonResponse.results];
      change(_pokemon, status: RxStatus.success());

      // Fetch the details after basic info is fetched
      for (var i = 0 + offset;
          i < pokemonResponse.results.length + offset;
          i++) {
        final pokemonDetail = await _pokemonDetailRepository.fetchPokemonDetail(
          pokemonResponse.results[i - offset].name,
        );
        if (pokemonDetail == null) {
          _pokemon[i].types = ["Normal"];
          continue;
        }
        _pokemon[i].types =
            pokemonDetail.types.map((type) => type.name).toList();
        change(_pokemon, status: RxStatus.success());
      }
      _isFetching = false;
    } catch (e, trace) {
      Logger().f(e, stackTrace: trace);
      change(null,
          status: RxStatus.error('An error occured while fetching pokemons'));
    }
  }
}
