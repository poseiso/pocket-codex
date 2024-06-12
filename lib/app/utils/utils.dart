import 'package:flutter/material.dart';

class Utils{
  static Color colorByType(String type){
    switch (type) {
      case 'normal':
        return Colors.grey;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'bug':
        return Colors.lightGreen;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'electric':
        return Colors.yellow;
      case 'fairy':
        return Colors.pink;
      default:
        return Colors.white;
    }
  }
}
