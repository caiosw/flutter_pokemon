import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';
import 'package:pokemon_dio/app/modules/home/domain/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/card_type.dart';
import 'domain/list_type.dart';

part 'pokemon_repository.g.dart';

@Injectable()
class PokemonRepository extends Disposable {
  static const OWNED_KEY = "OWNED_KEY";
  final DioForNative client;

  PokemonRepository(this.client);

  //dispose will be called automatically
  @override
  void dispose() {}

  String getKey(ListType listType) {
    if (listType == ListType.OWNED) {
      return 'OWNED_KEY';
    } else if (listType == ListType.FAVORITE) {
      return 'FAVORITE_KEY';
    }
    return null;
  }

  void addToList(ListType listType, Pokemon pokemon) async {
    String listKey = getKey(listType);
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(listKey);

    if (pokemons == null || pokemons.isEmpty) {
      pokemons = new List();
    }

    if (listType == ListType.OWNED) {
      pokemons.add(pokemon.toJson(CardType.MY_CARD));
    } else if (listType == ListType.FAVORITE) {
      pokemons.add(pokemon.toJson(CardType.FAVORITE));
    }

    shared.setStringList(listKey, pokemons);
  }

  void removeFromList(ListType listType, String pokemonId) async {
    String listKey = getKey(listType);
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(listKey)
        .map<Pokemon>((json) => Pokemon.fromJson(json))
        .toList();

    pokemons.removeWhere((element) => element.id == pokemonId);
    List<String> pokemonsJson =
      pokemons.map<String>((pokemon) => pokemon.toJson(pokemon.cardType)).toList();
    shared.setStringList(listKey, pokemonsJson);
  }



  Future<List<Pokemon>> getListedPokemons(ListType listType) async {
    String listKey = getKey(listType);
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(listKey);

    if (pokemons == null) {
      return [];
    }

    await updateOldPokemonList(pokemons);
    return shared
        .getStringList(listKey)
        .map<Pokemon>((json) => Pokemon.fromJson(json))
        .toList();
  }

  updateOldPokemonList (List<String>pokemons) async {
    var loadedPokemons =
        pokemons.map<Pokemon>((pokemon) => Pokemon.fromJson(pokemon)).toList();

    var mustReload = loadedPokemons
      .firstWhere((element) => element.cardType == CardType.PUBLIC, orElse: () => null);

    if (mustReload != null) {
      var shared = await SharedPreferences.getInstance();
      shared.setStringList(OWNED_KEY, []);
      for (Pokemon pokemon in loadedPokemons) {
        await addToList(ListType.OWNED, pokemon);
      }
    }
  }

  Future<List<Pokemon>> getAllPokemons() async {
    final response =
    await client.get('https://api.pokemontcg.io/v1/cards/');
    if (response != null && response.statusCode <= 300) {
      var pokemons = response.data['cards'];
      return pokemons.map<Pokemon>((json) => Pokemon.fromMapJson(json)).toList();
    }

    return [];
  }
}

