import 'package:flutter/material.dart';

class Utils {
  static Color colorByType(String type) {
    switch (type) {
      case 'normal':
        return Colors.brown;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'bug':
        return Colors.lightGreen;
      case 'dark':
        return Colors.black87;
      case 'dragon':
        return Colors.lightBlue;
      case 'fighting':
        return Colors.orange;
      case 'flying':
        return Colors.lightBlue;
      case 'ghost':
        return Colors.purple;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'electric':
        return Colors.lime;
      case 'ice':
        return Colors.blue;
      case 'psychic':
        return Colors.pink;
      case 'rock':
        return Colors.brown;
      case 'steel':
        return Colors.lightGreen;
      case 'fairy':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  static Color colorByStat(int stat) {
    if (stat < 50) {
      return Colors.red;
    } else if (stat < 90) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}
