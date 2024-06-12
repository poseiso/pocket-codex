import 'package:get/get.dart';

import '../../data/providers/providers.dart';
import '../../data/repositories/repositories.dart';
import 'home.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        repository: PokemonRepository(provider: PokemonProvider()),
        pokemonDetailRepository: PokemonDetailRepository(
          provider: PokemonDetailProvider(),
        ),
      ),
    );
  }
}
