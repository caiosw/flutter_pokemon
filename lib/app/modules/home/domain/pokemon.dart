import 'package:flutter/foundation.dart';

class Pokemon {

  final String id;
  final List<dynamic> types;
  final String imageUrl;
  final String imageUrlHiRes;
  final String name;

  Pokemon({
    @required this.id,
    @required this.types,
    @required this.imageUrl,
    @required this.imageUrlHiRes,
    @required this.name
  });

}