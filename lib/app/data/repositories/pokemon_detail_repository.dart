import '../models/models.dart';
import '../providers/providers.dart';

class PokemonDetailRepository {
  final PokemonDetailProvider provider;

  PokemonDetailRepository({required this.provider});

  Future<PokemonDetail?> fetchPokemonDetail(String name) async {
    final response = await provider.fetchPokemonDetail(name);
    if (response.isOk) {
      return PokemonDetail.fromJson(response.body);
    } else {
      return null;
    }
  }
}
