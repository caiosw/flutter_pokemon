import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_dio/app/modules/home/pokemon_repository.dart';

import 'domain/pokemon.dart';
import 'home_module.dart';

class PageDetail extends StatefulWidget {
  final Pokemon pokemon;

  const PageDetail({Key key, this.pokemon}) : super(key: key);
  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  bool showExpandedCard = false;

  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.pokemon.name),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.favorite),
                onPressed: null
            ),
            IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () => addToOwnedList()
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
                            child: Image.network(widget.pokemon.imageUrlHiRes)
                        ),
                      ),
                    ),
                  ),
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

  addToOwnedList() {
    repository.addToOwnedList(widget.pokemon);
    _key.currentState.showSnackBar(SnackBar(
        content: Text("Adicionado na lista de obtidos!"),
    ));
  }
}