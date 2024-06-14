import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class HomeController extends GetxController with StateMixin<List<PokemonItem>> {
  final PokemonRepository _repository;
  final PokemonTypeRepository _pokemonTypeRepository;
  final PokemonTypeDetailRepository _pokemonTypeDetailRepository;
  final PokemonDetailRepository _pokemonDetailRepository;
  final ScrollController scrollController = ScrollController();

  /// flag for preventing request spam
  bool _isFetching = false;
  int _offset = 0;
  Rx<String> filter = "All Type".obs;
  Rx<String> sort = "Id Ascending".obs;
  final List<String> sortList = ["Id Ascending", "Id Descending", "Name Ascending", "Name Descending"];

  HomeController({
    required PokemonRepository repository,
    required PokemonTypeRepository pokemonTypeRepository,
    required PokemonTypeDetailRepository pokemonTypeDetailRepository,
    required PokemonDetailRepository pokemonDetailRepository,
  })  : _repository = repository,
        _pokemonTypeRepository = pokemonTypeRepository,
        _pokemonTypeDetailRepository = pokemonTypeDetailRepository,
        _pokemonDetailRepository = pokemonDetailRepository;

  final pokemon = <PokemonItem>[].obs;
  var pokemonTypes = [PokemonType(name: "All Type", url: '')].obs;

  @override
  Future onInit() async {
    fetchAllPokemon();
    fetchAllType();
    scrollController.addListener(() {
      bool isAtBottom = scrollController.position.pixels >
          scrollController.position.maxScrollExtent;

      // Only all type is paginated due to its large item count
      if (isAtBottom && !_isFetching && filter.value == "All Type") {
        _offset += 50;
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
    // Start of the app or a change in filter
    if (_offset == 0) {
      change(null, status: RxStatus.loading());
    }

    try {
      _isFetching = true;

      final pokemonResponse = await _repository.fetchPokemon(0, 100000);
      if (pokemonResponse == null) {
        throw Exception("No result from fetch pokemon");
      }
      sortPokemon(pokemonResponse.results);
      pokemonResponse.results = pokemonResponse.results.sublist(_offset, _offset + 50);

      pokemon.value = [...pokemon, ...pokemonResponse.results];
      change(pokemon, status: RxStatus.success());

      await fetchDetails(pokemonResponse.results);
      _isFetching = false;
    } catch (e, trace) {
      Logger().d(e, stackTrace: trace);
    }
  }

  Future<void> fetchPokemonByType() async {
    // Start of the app or a change in filter
    if (_offset == 0) {
      change(null, status: RxStatus.loading());
    }
    try {
      _isFetching = true;
      final pokemonResponse =
          await _pokemonTypeDetailRepository.fetchPokemonType(filter.value);
      if (pokemonResponse == null) {
        throw Exception("No result from fetch pokemon");
      }

      pokemon.value = [...pokemon, ...pokemonResponse.pokemon];
      sortPokemon(pokemon);
      change(pokemon, status: RxStatus.success());

      await fetchDetails(pokemon);
      _isFetching = false;
    } catch (e, trace) {
      Logger().d(e, stackTrace: trace);
    }
  }

  /// Fetch all the available type filter
  Future<void> fetchAllType() async {
    // Currently there are 20 types
    // but only 18 tpe has pokemon data
    // offset will always be 0
    const typeLimit = 18;
    const typeOffset = 0;
    try {
      List<PokemonType>? typeReponse =
          await _pokemonTypeRepository.fetchPokemonType(typeOffset, typeLimit);
      if (typeReponse == null) {
        throw Exception("No result from fetch type");
      }
      pokemonTypes.value = [...pokemonTypes, ...typeReponse];
    } catch (e, trace) {
      Logger().f(e, stackTrace: trace);
    }
  }

  /// pass `pokemonList` to fetch the details of normal PokemonItem
  /// pass `pokemonTypeList` to fetch the details of PokemonItem in a type filter
  Future<void> fetchDetails(List<PokemonItem> pokemonList) async {
    for (var i = 0 + _offset; i < pokemonList.length + _offset; i++) {
      final pokemonDetail = await _pokemonDetailRepository.fetchPokemonDetail(
        pokemonList[i - _offset].name,
      );
      if (pokemonDetail == null) {
        pokemon[i].types = ["Normal"];
        continue;
      }
      pokemon[i].types = pokemonDetail.types.map((type) => type.name).toList();
      change(pokemon, status: RxStatus.success());
    }
  }

  void onChangeFilter(String newValue) {
    _offset = 0;
    if (newValue != filter.value) {
      change(null, status: RxStatus.loading());
      pokemon.clear();
    }

    filter.value = newValue;

    if (newValue == "All Type") {
      fetchAllPokemon();
    } else {
      fetchPokemonByType();
    }
  }

  void sortPokemon(List<PokemonItem> list) {
    switch (sort.value) {
      case "Id Ascending":
        list.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
        break;
      case "Id Descending":
        list.sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
      case "Name Ascending":
        list.sort((a, b) => a.name.compareTo((b.name)));
        break;
      case "Name Descending":
        list.sort((a, b) => b.name.compareTo((a.name)));
      default:
        list.sort((a, b) => int.parse(a.name).compareTo(int.parse(b.name)));
    }
    change(list, status: RxStatus.success());
  }

  void onChangeSort(String newValue) {
    _offset = 0;
    if (newValue != sort.value) {
      sort.value = newValue;
      if (filter.value == "All Type") {
        // Unlike the type filter,
        // when there's a sort change for all Pokemon,
        // the entire resource will require to be refetched.
        pokemon.clear();
        fetchAllPokemon();
      } else {
        // We need to refetch the details after sorting
        // because some of them might not have finished loading when the sort is changed.
        // This ensures that the correct details are displayed even when the order is changed.
        sortPokemon(pokemon);
        fetchDetails(pokemon);
      }
    }
  }
}
