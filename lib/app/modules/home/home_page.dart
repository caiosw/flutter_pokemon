import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_dio/app/modules/home/all_cards_page.dart';
import 'package:pokemon_dio/app/modules/home/favorites_page.dart';
import 'package:pokemon_dio/app/modules/home/my_cards_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  int _currentIndex = 0;

  List<Widget> pages = [
    AllCardsPage(),
    FavoritesPage(),
    MyCardsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => changePage(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            label: "Cards"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoritos"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_check),
            label: "Obtidos"
          )
        ],),
      body: IndexedStack(
        index: _currentIndex,
        children: pages
      ),
    );
  }

  changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}




