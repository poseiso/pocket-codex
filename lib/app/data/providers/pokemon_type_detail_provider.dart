import 'package:get/get_connect/connect.dart';

import '../../utils/app_config.dart';

class PokemonTypeDetailProvider extends GetConnect {
  final _baseUrl = AppConfig.baseUrl;
  final _endpoint = 'type';

  Future<Response> fetchPokemonTypeDetail(String name) {
    final url = '$_baseUrl/$_endpoint/$name';
    return get(url);
  }
}
