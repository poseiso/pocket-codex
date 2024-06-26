import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_codex/app/modules/home/home.dart';
import 'package:pocket_codex/app/modules/pokemon_detail/pokemon_detail.dart';
import 'package:pocket_codex/app/routes/app_pages.dart';

void main() {
  group('AppPages', () {
    test('Home route should return HomePage and HomeBinding', () {
      final route = AppPages.pages.firstWhere((page) => page.name == AppRoutes.home);
      expect(route.name, AppRoutes.home);
      expect(route.page(), isA<HomePage>());
      expect(route.binding, isA<HomeBinding>());
    });

    test('PokemonDetail route should return PokemonDetailPage and PokemonDetailBinding', () {
      final route = AppPages.pages.firstWhere((page) => page.name == AppRoutes.pokemonDetail);
      expect(route.name, AppRoutes.pokemonDetail);
      expect(route.page(), isA<PokemonDetailPage>());
      expect(route.binding, isA<PokemonDetailBinding>());
    });
  });
}
