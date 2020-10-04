import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';
import 'package:pokemon_dio/app/modules/home/domain/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pokemon_repository.g.dart';

@Injectable()
class PokemonRepository extends Disposable {
  static const OWNED_KEY = "OWNED_KEY";
  final DioForNative client;

  PokemonRepository(this.client);

  Future fetchPost() async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}

  void addToOwnedList(Pokemon pokemon) async {
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(OWNED_KEY);

    if (pokemons == null || pokemons.isEmpty) {
      pokemons = new List();
    }

    pokemons.add(pokemon.toJson());
    shared.setStringList(OWNED_KEY, pokemons);

    print(shared.getStringList(OWNED_KEY));
  }
}
