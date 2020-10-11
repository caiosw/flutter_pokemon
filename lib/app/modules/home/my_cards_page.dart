import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';
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
      body: Observer(
        builder: (_) => GridView.count(
          childAspectRatio: 0.72,
          crossAxisCount: 2,
          children: List.generate(controller.getOwnedPokemons().length, (index) {
            var pokemon = controller.getOwnedPokemons()[index];
            return GestureDetector(
              onTap: () => openPageDetail(pokemon),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Hero(
                  tag: pokemon.uniqueId,
                  child: Image.network(pokemon.imageUrl)
                )
              )
            );
          }),
        )
      )
    );
  }

  openPageDetail(Pokemon pokemon) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return PageDetail(pokemon: pokemon);
        })
    );
  }
}




