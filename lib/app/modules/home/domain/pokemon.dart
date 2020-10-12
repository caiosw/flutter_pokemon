import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../home_controller.dart';
import '../home_module.dart';
import '../pokemon_repository.dart';
import 'card_type.dart';

class Pokemon {
  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();
  final HomeController controller = HomeModule.to.get<HomeController>();

  final String id;
  final List<dynamic> types;
  final String imageUrl;
  final String imageUrlHiRes;
  final String name;
  final CardType cardType;

  Pokemon({
    @required this.id,
    @required this.types,
    @required this.imageUrl,
    @required this.imageUrlHiRes,
    @required this.name,
    @required this.cardType
  });

  bool owned () {
    var found = controller.pokemons.firstWhere(
      (element) => element.id == id,
      orElse: () => null
    );

    return found != null;
  }

  bool favorite () {
    var found = controller.favoritePokemons.firstWhere(
            (element) => element.id == id,
        orElse: () => null
    );

    return found != null;
  }

  String uniqueId() {
    print(cardType.toString() + id);
    return cardType.toString() + id;
  }

  String toJson(CardType cardType) {
    Map<String, dynamic> json = _fromMapJson(cardType);
    return jsonEncode(json);
  }

  Map <String, dynamic> _fromMapJson(CardType customCardType) {
    return {
      'id': id,
      'types': types,
      'imageUrl': imageUrl,
      'imageUrlHiRes': imageUrlHiRes,
      'name': name,
      'cardType': customCardType.toString()
    };
  }

  static Pokemon fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return fromMapJson(map);
  }

  static Pokemon fromMapJson(Map<String, dynamic> map) {
    return Pokemon(
        id: map['id'],
        imageUrl: map['imageUrl'],
        imageUrlHiRes: map['imageUrlHiRes'],
        name: map['name'],
        types: map['types'],
        cardType: CardTypeHelper.fromString(map['cardType'])
    );
  }


}

