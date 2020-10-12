import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';
import 'package:pokemon_dio/app/modules/home/search.dart';
import 'detail_page.dart';
import 'domain/pokemon.dart';
import 'home_controller.dart';
import 'home_module.dart';
import 'package:transparent_image/transparent_image.dart';

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
            return GestureDetector(
              onTap: () => openPageDetail(pokemon),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Hero(
                  tag: pokemon.uniqueId,
                  child: Stack(children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: pokemon.imageUrl)
                    )
                  ])
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




