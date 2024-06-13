import 'package:flutter/material.dart';

class Utils {
  static Color colorByType(String type) {
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
        return Colors.lime;
      case 'fairy':
        return Colors.pink;
      default:
        return Colors.white;
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
