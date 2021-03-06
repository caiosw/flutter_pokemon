import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';
import 'domain/list_type.dart';
import 'domain/pokemon.dart';
import 'home_module.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();

  @observable
  List<Pokemon> pokemons = ObservableList();

  @action
  updateOwnedPokemons() async {
    pokemons = await _updateOwnedPokemons();
  }

  List<Pokemon> getOwnedPokemons () => pokemons;

  Future<List<Pokemon>> _updateOwnedPokemons () {
    return repository.getListedPokemons(ListType.OWNED);
  }

  addToOwnedList (Pokemon pokemon) {
    repository.addToList(ListType.OWNED, pokemon);
    updateOwnedPokemons();
  }

  removeFromOwnedList (String pokemonId) async {
    repository.removeFromList(ListType.OWNED, pokemonId);
    updateOwnedPokemons();
  }

  @observable
  List<Pokemon> favoritePokemons = ObservableList();

  @action
  updateFavoritePokemons() async {
    favoritePokemons = await _updateFavoritePokemons();
  }

  List<Pokemon> getFavoritePokemons () => favoritePokemons;

  Future<List<Pokemon>> _updateFavoritePokemons () {
    return repository.getListedPokemons(ListType.FAVORITE);
  }

  addToFavoriteList (Pokemon pokemon) {
    repository.addToList(ListType.FAVORITE, pokemon);
    updateFavoritePokemons();
  }

  removeFromFavoriteList (String pokemonId) async {
    repository.removeFromList(ListType.FAVORITE, pokemonId);
    updateFavoritePokemons();
  }

  Future<List<Pokemon>> getAllPokemons () {
    return repository.getAllPokemons();
  }

}
