import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/search.dart';
import 'package:pokemon_dio/app/modules/home/thumbnail_card.dart';
import 'detail_page.dart';
import 'domain/pokemon.dart';
import 'home_controller.dart';
import 'home_module.dart';

class FavoritesPage extends StatefulWidget {

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ModularState<FavoritesPage, HomeController> {
  //use 'controller' variable to access controller

  final HomeController controller = HomeModule.to.get<HomeController>();

  @override
  void initState() {
    controller.updateFavoritePokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards Favoritos"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(controller.getFavoritePokemons()));
            }
          )
        ],
      ),
      body: Observer(
        builder: (_) => GridView.count(
          childAspectRatio: 0.72,
          crossAxisCount: 2,
          children: List.generate(controller.getFavoritePokemons().length, (index) {
            var pokemon = controller.getFavoritePokemons()[index];
            return ThumbnailCards(pokemon: pokemon);
          }),
        )
      )
    );
  }
}




