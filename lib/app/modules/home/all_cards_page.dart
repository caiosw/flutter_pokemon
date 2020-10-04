import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'detail_page.dart';
import 'domain/pokemon.dart';
import 'home_controller.dart';

class AllCardsPage extends StatefulWidget {

  @override
  _AllCardsPageState createState() => _AllCardsPageState();
}

class _AllCardsPageState extends ModularState<AllCardsPage, HomeController> {
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



