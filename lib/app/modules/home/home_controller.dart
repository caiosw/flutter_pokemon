import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';

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
    return repository.getOwnedPokemons();
  }

  addToOwnedList (Pokemon pokemon) {
    repository.addToOwnedList(pokemon);
    updateOwnedPokemons();
  }

  Future<List<Pokemon>> getAllPokemons () {
    return repository.getAllPokemons();
  }

  removeFromOwnedList (String pokemonId) async {
    repository.removeFromOwnedList(pokemonId);
    updateOwnedPokemons();
  }

}
