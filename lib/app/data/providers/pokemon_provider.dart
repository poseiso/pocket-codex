import 'package:get/get_connect/connect.dart';

import '../../utils/app_config.dart';

class PokemonProvider extends GetConnect {
  final _baseUrl = AppConfig.baseUrl;
  final _endpoint = 'pokemon';

  Future<Response> fetchPokemons(int offset, int limit) {
    final url = '$_baseUrl/$_endpoint?limit=$limit&offset=$offset';
    return get(url);
  }
}
