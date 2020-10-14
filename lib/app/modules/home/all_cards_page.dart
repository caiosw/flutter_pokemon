import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';
import 'package:pokemon_dio/app/modules/home/search.dart';
import 'package:pokemon_dio/app/modules/home/thumbnail_card.dart';
import 'domain/pokemon.dart';
import 'home_controller.dart';
import 'home_module.dart';

class AllCardsPage extends StatefulWidget {

  @override
  _AllCardsPageState createState() => _AllCardsPageState();
}

class _AllCardsPageState extends ModularState<AllCardsPage, HomeController> {
  //use 'controller' variable to access controller

  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();

  List<Pokemon> pokemons = [];

  @override
  void initState() {
    loadPokemons();
    super.initState();
  }

  void loadPokemons () async {
    var allPokemons = await repository.getAllPokemons();
    setState(() {
      pokemons = allPokemons;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Cards"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(pokemons));
            }
          )
        ],
      ),
      body: GridView.count(
        childAspectRatio: 0.72,
        crossAxisCount: 2,
        children: List.generate(pokemons.length, (index) {
          return ThumbnailCards(pokemon: pokemons[index]);
        }),
      ),
    );
  }
}




