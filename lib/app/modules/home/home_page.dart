import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'domain/pokemon.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  List<Pokemon> pokemons = [
      Pokemon(
        id: '1',
        types: ['Water'],
        imageUrl: 'https://images.pokemontcg.io/ex16/16.png',
        imageUrlHiRes: 'https://images.pokemontcg.io/ex16/16_hires.png',
        name: 'Bulbasaur'
      ),
      Pokemon(
          id: '21',
          types: ['Fire'],
          imageUrl: 'https://images.pokemontcg.io/ex16/17.png',
          imageUrlHiRes: 'https://images.pokemontcg.io/ex16/17_hires.png',
          name: 'Charizard'
      ),
    Pokemon(
        id: '3',
        types: ['Fire'],
        imageUrl: 'https://images.pokemontcg.io/ex16/18.png',
        imageUrlHiRes: 'https://images.pokemontcg.io/ex16/18_hires.png',
        name: 'Rato'
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 0.72,
        crossAxisCount: 2,
        children: List.generate(pokemons.length, (index) {
          var pokemon = pokemons[index];

          return GestureDetector(
            onTap: () => openPageDetail(pokemon),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Hero(
                tag: pokemon.id,
                child: Image.network(pokemon.imageUrl)
              )
            )
          );
        }),
      ),
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

class PageDetail extends StatefulWidget {
  final Pokemon pokemon;

  const PageDetail({Key key, this.pokemon}) : super(key: key);
  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  bool showExpandedCard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        centerTitle: true,
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
                    tag: widget.pokemon.id,
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
}


