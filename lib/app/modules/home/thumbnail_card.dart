import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'domain/pokemon.dart';

class ThumbnailCards extends StatelessWidget {
  // make these final
  final Pokemon pokemon;

  // constructor
  const ThumbnailCards({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openPageDetail(context, pokemon),
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
                  child: Icon(Icons.favorite, color: Colors.white),
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
                  child: Icon(Icons.check_box, color: Colors.white),
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
  }

  openPageDetail(context, Pokemon pokemon) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return PageDetail(pokemon: pokemon);
        })
    );
  }
}




