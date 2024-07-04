import 'package:flutter/material.dart';
import 'package:pocket_codex/app/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test('colorByType returns correct color for each type', () {
    expect(Utils.colorByType('normal'), Colors.brown);
    expect(Utils.colorByType('fire'), Colors.red);
    expect(Utils.colorByType('water'), Colors.blue);
    expect(Utils.colorByType('grass'), Colors.green);
    expect(Utils.colorByType('bug'), Colors.lightGreen);
    expect(Utils.colorByType('dark'), Colors.black87);
    expect(Utils.colorByType('dragon'), Colors.lightBlue);
    expect(Utils.colorByType('fighting'), Colors.orange);
    expect(Utils.colorByType('flying'), Colors.lightBlue);
    expect(Utils.colorByType('ghost'), Colors.purple);
    expect(Utils.colorByType('poison'), Colors.purple);
    expect(Utils.colorByType('ground'), Colors.brown);
    expect(Utils.colorByType('electric'), Colors.lime);
    expect(Utils.colorByType('ice'), Colors.blue);
    expect(Utils.colorByType('psychic'), Colors.pink);
    expect(Utils.colorByType('rock'), Colors.brown);
    expect(Utils.colorByType('steel'), Colors.lightGreen);
    expect(Utils.colorByType('fairy'), Colors.pink);
    expect(Utils.colorByType('unknown'), Colors.grey); // test for default case
  });

  test('colorByStat returns correct color for each stat range', () {
    expect(Utils.colorByStat(0), Colors.red); // stat < 50
    expect(Utils.colorByStat(49), Colors.red); // stat < 50
    expect(Utils.colorByStat(50), Colors.yellow); // 50 <= stat < 90
    expect(Utils.colorByStat(89), Colors.yellow); // 50 <= stat < 90
    expect(Utils.colorByStat(90), Colors.green); // stat >= 90
    expect(Utils.colorByStat(100), Colors.green); // stat >= 90
  });
}
