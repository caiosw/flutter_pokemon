// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$pokemonsAtom = Atom(name: '_HomeControllerBase.pokemons');

  @override
  List<Pokemon> get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(List<Pokemon> value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  final _$favoritePokemonsAtom =
      Atom(name: '_HomeControllerBase.favoritePokemons');

  @override
  List<Pokemon> get favoritePokemons {
    _$favoritePokemonsAtom.reportRead();
    return super.favoritePokemons;
  }

  @override
  set favoritePokemons(List<Pokemon> value) {
    _$favoritePokemonsAtom.reportWrite(value, super.favoritePokemons, () {
      super.favoritePokemons = value;
    });
  }

  final _$updateOwnedPokemonsAsyncAction =
      AsyncAction('_HomeControllerBase.updateOwnedPokemons');

  @override
  Future updateOwnedPokemons() {
    return _$updateOwnedPokemonsAsyncAction
        .run(() => super.updateOwnedPokemons());
  }

  final _$updateFavoritePokemonsAsyncAction =
      AsyncAction('_HomeControllerBase.updateFavoritePokemons');

  @override
  Future updateFavoritePokemons() {
    return _$updateFavoritePokemonsAsyncAction
        .run(() => super.updateFavoritePokemons());
  }

  @override
  String toString() {
    return '''
pokemons: ${pokemons},
favoritePokemons: ${favoritePokemons}
    ''';
  }
}
