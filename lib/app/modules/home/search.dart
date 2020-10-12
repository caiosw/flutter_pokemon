import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'domain/pokemon.dart';

class Search extends SearchDelegate {
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

  Pokemon selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult.name)
      )
    );
  }

  final List<Pokemon> listExample;
  Search(this.listExample);
  List<Pokemon> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Pokemon> suggestionList = [];
    query.isEmpty ? suggestionList = recentList : suggestionList.addAll(
      listExample.where((element) => element.name.toLowerCase().contains(
        query.toLowerCase()
      ))
    );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          onTap: () {
            selectedResult = suggestionList[index];
            openPageDetail(context, selectedResult);
            recentList.add(selectedResult);
          },
        );
      },

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
