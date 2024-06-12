import 'package:get/get_connect/connect.dart';
import 'package:pocket_codex/app/utils/app_config.dart';

class PokemonDetailProvider extends GetConnect {
  final _baseUrl = AppConfig.baseUrl;
  final _pokemonEndpoint = 'pokemon';

  Future<Response> fetchPokemonDetail(String name) {
    final url = '$_baseUrl/$_pokemonEndpoint/$name';
    return get(url);
  }
}
