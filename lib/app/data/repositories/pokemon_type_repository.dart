import '../models/models.dart';
import '../providers/providers.dart';

class PokemonTypeRepository {
  final PokemonTypeProvider provider;

  PokemonTypeRepository({required this.provider});

  Future<List<PokemonType>?> fetchPokemonType(int offset, int? limit) async {
    final rp = await provider.fetchTypes(offset, limit ?? 50);
    if (rp.isOk) {
      return PokemonType.fromListOfJson(rp.body);
    }
    return null;
  }
}
