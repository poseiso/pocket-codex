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

  Future<Evolution?> fetchEvolution(int id) async {
    final response = await provider.fetchEvolution(id);
    if (response.isOk) {
      return Evolution.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<PokemonSpecies?> fetchSpecies(int id) async {
    final response = await provider.fetchSpecies(id);
    if (response.isOk) {
      return PokemonSpecies.fromJson(response.body);
    } else {
      return null;
    }
  }
}
