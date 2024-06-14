import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

class PokemonDetailController extends GetxController {
  final PokemonDetailRepository _repository;

  PokemonDetailController({required PokemonDetailRepository repository})
      : _repository = repository;

  final _isLoading = true.obs;
  final _isError = false.obs;
  final _pokemon = Rxn<PokemonDetail>();
  final _pokemonItem = Rxn<PokemonItem>();
  final _evolution = Rxn<Evolution>();
  final _species = Rxn<PokemonSpecies>();

  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
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
    _isLoading.value = true;
    _isError.value = false;
    try {
      _pokemonItem.value = Get.arguments['detail'];
      final detailResponse =
          await _repository.fetchPokemonDetail(_pokemonItem.value!.name);
      if (detailResponse == null) {
        _isError.value = true;
        throw Exception("No result from fetch pokemon");
      }
      _pokemon.value = detailResponse;

      final speciesResponse = await _repository.fetchSpecies(pokemon!.id);
      if (speciesResponse == null) {
        _isError.value = true;
        throw Exception("No result from fetch pokemon");
      }
      _species.value = speciesResponse;

      final id = speciesResponse.evolutionChain.url.split('/');
      _evolution.value =
          await _repository.fetchEvolution(int.parse(id[id.length - 2]));

      _isLoading.value = false;
    } catch (error, trace) {
      _isLoading.value = false;
      Logger().f(error, stackTrace: trace);
    }
  }

  String get abilities {
    return pokemon!.abilities.map((item) => item.name).join(', ');
  }

  String get listPokeMove {
    return pokemon!.moves
        .map((element) =>
            element.name[0].toUpperCase() + element.name.substring(1))
        .join(', ');
  }
}
