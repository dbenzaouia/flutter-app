int sleepJ = 1; // durée du sommeil cette nuit
int sleepJ_1 = 2; // durée du sommeil Hier
int sleepAverage = 3; // durée moyenne du sommeil

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

}

List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/sleep.png',
      titleTxt: 'Cette nuit',
      kacl: sleepJ,
      meals: <String>['nuit'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/sleep.png',
      titleTxt: 'Hier',
      kacl: sleepJ_1,
      meals: <String>['hier'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/sleep.png',
      titleTxt: 'En moyenne',
      kacl: sleepAverage,
      meals: <String>['average'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      kacl: 0,
      meals: <String>[],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
