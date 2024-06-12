import 'dart:convert';

import 'models.dart';

class Pokemon {
  final int count;
  final String next;
  final List<Desc> results;

  Pokemon({
    required this.count,
    required this.next,
    required this.results,
  });

  factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      count: json["count"],
      next: json["next"],
      results: List<Desc>.from(
        json["results"].map(
          (x) => Desc.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "next": next,
      "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
  }
}
