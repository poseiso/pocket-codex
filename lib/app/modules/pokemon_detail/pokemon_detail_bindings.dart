import 'package:get/get.dart';

import '../../data/providers/providers.dart';
import '../../data/repositories/repositories.dart';
import 'pokemon_detail.dart';

class PokemonDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PokemonDetailController(
        repository: PokemonDetailRepository(
          provider: PokemonDetailProvider(),
        ),
      ),
    );
  }
}
