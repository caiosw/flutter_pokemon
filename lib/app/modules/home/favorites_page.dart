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
                    Center(child: FadeInImage.assetNetwork(
                        placeholder: 'assets/spinning_pokeball_sm.gif',
                        image: pokemon.imageUrl)
                    ),
                    Visibility(
                      visible: pokemon.favorite(),
                      child: Positioned(
                        bottom: 5, left: -12, //give the values according to your requirement
                        child: RawMaterialButton(
                          fillColor: Colors.red,
                          child: Icon(Icons.favorite, color: Colors.white,),
                          padding: EdgeInsets.all(5.0),
                          shape: CircleBorder(),
                          onPressed: () {  },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: pokemon.owned(),
                      child: Positioned(
                        bottom: 5, right: -12, //give the values according to your requirement
                        child: RawMaterialButton(
                          fillColor: Colors.blue,
                          child: Icon(Icons.check_box, color: Colors.white,),
                          padding: EdgeInsets.all(5.0),
                          shape: CircleBorder(),
                          onPressed: () {  },
                        ),
                      ),
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




