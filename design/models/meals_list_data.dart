import 'package:flutter/cupertino.dart';

import '../../data/database.dart';
import 'dart:async';
import '../../hometime.dart';

class MealsListData {
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  int id;
  int kacl;

  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.id,
    this.kacl = 0,
  });
}

/* Future<List<MealsListData>> afficheList() async {
  int sleepJ = await DBProvider().getSleepByDay(HTState.todayYear(),
      HTState.todayMonths(), HTState.todayDay()); // durée du sommeil cette nuit
  int sleepJ_1 = 2; // durée du sommeil Hier
  int sleepAverage = 3; // durée moyenne du sommeil

 
  return tabIconsList;
} */

List<MealsListData> tabIconsList = <MealsListData>[
  MealsListData(
    imagePath: 'assets/fitness_app/sleep.png',
    titleTxt: 'Cette nuit',
    kacl: 202,
    id: 0,
    startColor: '#FA7D82',
    endColor: '#FFB295',
  ),
  MealsListData(
    imagePath: 'assets/fitness_app/sleep.png',
    titleTxt: 'Hier',
    kacl: 0,
    id: 1,
    startColor: '#738AE6',
    endColor: '#5C5EDD',
  ),
  MealsListData(
    imagePath: 'assets/fitness_app/sleep.png',
    titleTxt: 'En moyenne',
    kacl: 132,
    id: 2,
    startColor: '#FE95B6',
    endColor: '#FF5287',
  ),
];
