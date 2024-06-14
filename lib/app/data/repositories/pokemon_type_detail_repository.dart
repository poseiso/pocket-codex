import '../models/models.dart';
import '../providers/providers.dart';

class PokemonTypeDetailRepository {
  final PokemonTypeDetailProvider provider;

  PokemonTypeDetailRepository({required this.provider});

  Future<PokemonTypeDetail?> fetchPokemonType(String name) async {
    final rp = await provider.fetchPokemonTypeDetail(name);
    if (rp.isOk) {
      return PokemonTypeDetail.fromJson(rp.body);
    }
    return null;
  }
}
