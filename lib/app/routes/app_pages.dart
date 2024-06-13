import 'package:get/get.dart';

import '../modules/home/home.dart';
import '../modules/pokemon_detail/pokemon_detail.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.pokemonDetail,
      page: () => const PokemonDetailPage(),
      binding: PokemonDetailBinding(),
    ),
  ];
}
