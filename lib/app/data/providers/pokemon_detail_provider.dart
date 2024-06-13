import 'package:get/get_connect/connect.dart';
import 'package:pocket_codex/app/utils/app_config.dart';

class PokemonDetailProvider extends GetConnect {
  final _baseUrl = AppConfig.baseUrl;
  final _pokemonEndpoint = 'pokemon';
  final _evolutionEndpoint = 'evolution-chain';
  final _speciesEndpoint = 'pokemon-species';

  Future<Response> fetchPokemonDetail(String name) {
    final url = '$_baseUrl/$_pokemonEndpoint/$name';
    return get(url);
  }

  Future<Response> fetchEvolution(int id) {
    final url = '$_baseUrl/$_evolutionEndpoint/$id';
    return get(url);
  }

  Future<Response> fetchSpecies(int id) {
    final url = '$_baseUrl/$_speciesEndpoint/$id';
    return get(url);
  }
}
