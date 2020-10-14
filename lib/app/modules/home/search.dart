import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'domain/pokemon.dart';
import 'home_module.dart';
import 'pokemon_repository.dart';

class Search extends SearchDelegate {
  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: selectedResult != null ? Text(selectedResult.name) : Text("")
      )
    );
  }

  final List<Pokemon> listExample;
  Search(this.listExample);

  Pokemon selectedResult;

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: repository.getSearchHistory(),
      builder: (context, AsyncSnapshot<List<Pokemon>> recentList) {
        List<Pokemon> suggestionList = [];

        List<Pokemon> pokemons;
        if (recentList.hasData) {
          pokemons = recentList.data;
        } else {
          pokemons = [];
        }

        query.isEmpty ? suggestionList = pokemons : suggestionList.addAll(
          listExample.where((element) => element.name.toLowerCase()
            .contains(query.toLowerCase()
          )
        ));

        return ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestionList[index].name),
              onTap: () {
                selectedResult = suggestionList[index];
                openPageDetail(context, selectedResult);
                repository.addToSearchHistory(selectedResult);
              },
            );
          },
        );
      }
    );
  }

  void openPageDetail(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return PageDetail(pokemon: pokemon);
        })
    );
  }
}
