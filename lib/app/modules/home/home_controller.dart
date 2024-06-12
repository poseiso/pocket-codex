import 'package:get/get.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class HomeController extends GetxController
    with StateMixin<List<PokemonDetail>> {
  final PokemonRepository _repository;
  final PokemonDetailRepository _pokemonDetailRepository;

  HomeController(
      {required PokemonRepository repository,
      required PokemonDetailRepository pokemonDetailRepository})
      : _repository = repository,
        _pokemonDetailRepository = pokemonDetailRepository;

  final _offset = 0.obs;
  final _pokemon = <PokemonDetail>[].obs;

  int get offset => _offset.value;

  List<PokemonDetail> get pokemon => _pokemon;

  @override
  Future onInit() async {
    fetchAllPokemon();
    super.onInit();
  }

  Future<void> fetchAllPokemon() async {
    _pokemon.clear();
    change(null, status: RxStatus.loading());

    try {
      final pokemonResponse =
          await _repository.fetchPokemon(_offset.value, null);

      if (pokemonResponse != null) {
        for (var result in pokemonResponse.results) {
          try {
            final pokemonDetail =
                await _pokemonDetailRepository.fetchPokemonDetail(result.name);
            if (pokemonDetail != null) {
              _pokemon.add(pokemonDetail);
              change(_pokemon, status: RxStatus.success());
            } else {
              change(null,
                  status: RxStatus.error('Could not fetch Pokemon details.'));
            }
          } catch (error) {
            change(null,
                status: RxStatus.error(
                    'An error occurred while fetching Pokemon details: $error'));
          }
        }
      } else {
        change(null, status: RxStatus.error('No Pokemon found.'));
      }
    } catch (error) {
      change(null,
          status: RxStatus.error(
              'An error occurred while fetching Pokemon: $error'));
    }
  }
}
