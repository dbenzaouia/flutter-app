class SleepListData {
  SleepListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.sleep,
    this.duration,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> sleep;
  int duration;


  List<SleepListData> tabIconsList = <SleepListData>[
    SleepListData(
      imagePath: 'assets/fitness_app/sleep.png',
      titleTxt: 'Tonight',
      duration: 0,
      sleep: <String>[],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    SleepListData(
      imagePath: 'assets/fitness_app/sleep.png',
      titleTxt: 'Yesterday',
      duration: 0,
      sleep: <String>[],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    SleepListData(
      imagePath: 'assets/fitness_app/sleep.png',
      titleTxt: 'Average',
      duration: 0,
      sleep: <String>[],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    SleepListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      duration: 0,
      sleep: <String>[],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];

 
}
