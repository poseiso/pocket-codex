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
  final _evolution = Rxn<Evolution>();
  final _species = Rxn<PokemonSpecies>();

  bool get isLoading => _isLoading.value;

  PokemonDetail? get pokemon => _pokemon.value;

  Evolution? get evolution => _evolution.value;

  PokemonSpecies? get species => _species.value;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonDetail();
  }

  Future<void> fetchPokemonDetail() async {
    try {
      _pokemon.value = Get.arguments['detail'];

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
    return pokemon!.abilities.map((item) => item.ability.name).join(', ');
  }

  String listPokeMove() {
    return pokemon!.moves
        .map((element) =>
            element.move.name[0].toUpperCase() + element.move.name.substring(1))
        .join(', ');
  }
}
