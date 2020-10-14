import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/search.dart';
import 'package:pokemon_dio/app/modules/home/thumbnail_card.dart';
import 'detail_page.dart';
import 'domain/pokemon.dart';
import 'home_controller.dart';
import 'home_module.dart';

class MyCardsPage extends StatefulWidget {

  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends ModularState<MyCardsPage, HomeController> {
  //use 'controller' variable to access controller

  final HomeController controller = HomeModule.to.get<HomeController>();

  @override
  void initState() {
    controller.updateOwnedPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards Obtidos"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(controller.getOwnedPokemons()));
            }
          )
        ],
      ),
      body: Observer(
        builder: (_) => GridView.count(
          childAspectRatio: 0.72,
          crossAxisCount: 2,
          children: List.generate(controller.getOwnedPokemons().length, (index) {
            var pokemon = controller.getOwnedPokemons()[index];
            return ThumbnailCards(pokemon: pokemon);
          }),
        )
      )
    );
  }
}




