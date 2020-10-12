import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_dio/app/modules/home/home_controller.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';

import 'domain/pokemon.dart';
import 'home_module.dart';
import 'package:transparent_image/transparent_image.dart';

class PageDetail extends StatefulWidget {
  final Pokemon pokemon;

  const PageDetail({Key key, this.pokemon}) : super(key: key);
  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  bool showExpandedCard = false;
  bool ownedPokemon;
  bool favoritePokemon;

  final HomeController controller = HomeModule.to.get<HomeController>();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ownedPokemon = widget.pokemon.owned();
    favoritePokemon = widget.pokemon.favorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.pokemon.name,
          style: TextStyle(color: Colors.red)
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          IconButton(
              icon: favoritePokemon
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite, color: Colors.grey),
              onPressed: () => addOrRemoveFromFavoriteList()
          ),
          IconButton(
              icon: ownedPokemon
                ? Icon(Icons.person_remove, color: Colors.blue)
                : Icon(Icons.person_add, color: Colors.blue),
              onPressed: () => addOrRemoveFromOwnedList()
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => changeCardExibition(),
              child: Visibility(
                visible: !showExpandedCard,
                child: Hero(
                  tag: widget.pokemon.uniqueId,
                  child: Image.network(widget.pokemon.imageUrl)
                ),
              ),
            ),
            GestureDetector(
              onTap: () => changeCardExibition(),
              child: Visibility(
                visible: showExpandedCard,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Stack(children: <Widget>[
                      Center(child: CircularProgressIndicator()),
                      Center(child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.pokemon.imageUrlHiRes
                      ))
                    ]),
                  ),
                ),
              ),
            )
          ]
        )
      )
    );
  }

  changeCardExibition() {
    setState(() {
      showExpandedCard = !showExpandedCard;
    });
  }

  addOrRemoveFromOwnedList() {
    if (ownedPokemon) {
      controller.removeFromOwnedList(widget.pokemon.id);
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Removido da lista de obtidos!"),
      ));
    } else {
      controller.addToOwnedList(widget.pokemon);
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Adicionado na lista de obtidos!"),
      ));
    }

    setState(() {
      ownedPokemon = !ownedPokemon;
    });
  }

  addOrRemoveFromFavoriteList() {
    if (favoritePokemon) {
      controller.removeFromFavoriteList(widget.pokemon.id);
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Removido da lista de favoritos!"),
      ));
    } else {
      controller.addToFavoriteList(widget.pokemon);
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Adicionado na lista de favoritos!"),
      ));
    }

    setState(() {
      favoritePokemon = !favoritePokemon;
    });
  }
}