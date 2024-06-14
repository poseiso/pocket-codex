import 'package:get/get_connect/connect.dart';

import '../../utils/app_config.dart';

class PokemonTypeProvider extends GetConnect {
  final _baseUrl = AppConfig.baseUrl;
  final _endpoint = 'type';

  Future<Response> fetchTypes(int offset, int limit) {
    final url = '$_baseUrl/$_endpoint?limit=$limit&offset=$offset';
    return get(url);
  }
}
