import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class PokemonDetailController extends GetxController {
  final PokemonDetailRepository _repository;

  PokemonDetailController({required PokemonDetailRepository repository})
      : _repository = repository;

  final _isLoading = true.obs;
  final _pokemon = Rxn<PokemonDetail>();
  final _pokemonItem = Rxn<PokemonItem>();
  final _evolution = Rxn<Evolution>();
  final _species = Rxn<PokemonSpecies>();

  bool get isLoading => _isLoading.value;
  PokemonDetail? get pokemon => _pokemon.value;
  PokemonItem? get pokemonItem => _pokemonItem.value;
  Evolution? get evolution => _evolution.value;
  PokemonSpecies? get species => _species.value;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonDetail();
  }

  Future<void> fetchPokemonDetail() async {
    try {
      _pokemonItem.value = Get.arguments['detail'];
      final detailResponse =
          await _repository.fetchPokemonDetail(_pokemonItem.value!.name);
      _pokemon.value = detailResponse;

      final speciesResponse = await _repository.fetchSpecies(pokemon!.id);
      if (speciesResponse != null) {
        _species.value = speciesResponse;

        final id = speciesResponse.evolutionChain.url.split('/');
        _evolution.value =
            await _repository.fetchEvolution(int.parse(id[id.length - 2]));
      }

      _isLoading.value = false;
    } catch (error) {
      Logger().d(error);
    }
  }

  String get abilities {
    return pokemon!.abilities.map((item) => item.name).join(', ');
  }

  String listPokeMove() {
    return pokemon!.moves
        .map((element) =>
            element.name[0].toUpperCase() + element.name.substring(1))
        .join(', ');
  }
}
