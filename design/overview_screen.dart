import 'package:design/Configuration.dart';

import './ui_view/glass_view.dart';
import './ui_view/hometime_view.dart';
import './ui_view/title_view.dart';
import './second_app_theme.dart';
import './widget_list.dart';
import '../main.dart';
import './ui_view/running_view.dart';
import './ui_view/location_view.dart';
import './ui_view/blue_view.dart';
import './ui_view/workout_view.dart';
import 'package:flutter/material.dart';
import '../data/database.dart';
import '../configModel.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  int hometime;
  int sleeptime;
  int pedometre;
  int location;
  int bluetooth;

  @override
  void initState() {
    hometime = 0;
    sleeptime = 0;
    pedometre = 0;
    location = 0;
    bluetooth = 0;
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void loadConfig() async {
    var _config = await dataBase.getConfig(1);
    print(_config.hometime);
    setState(() {
      hometime = _config.hometime;
      sleeptime = _config.sleeptime;
      pedometre = _config.pedometre;
      location = _config.location;
      bluetooth = _config.bluetooth;
    });
  }

  void addAllListData() async{
    loadConfig();
    const int count = 9;

    //pedometre canva

    listViews.add(
      InkWell(
          child: TitleView(
            titleTxt: 'Pedomètre',
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (pedometre == 1) {
              Navigator.pushNamed(context, '/first');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Pedometre'),
                  content: Text(
                      'In order to activate Pedometre, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
    listViews.add(
      InkWell(
          child: WorkoutView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (pedometre == 1) {
              Navigator.pushNamed(context, '/first');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Pedometre'),
                  content: Text(
                      'In order to activate Pedometre, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );

    listViews.add(
      InkWell(
          child: RunningView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 3, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (pedometre == 1) {
              Navigator.pushNamed(context, '/first');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Pedometre'),
                  content: Text(
                      'In order to activate Pedometre, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );

    //hometime canva

    listViews.add(
      InkWell(
          child: TitleView(
            titleTxt: 'HomeTime',
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (hometime == 1) {
              Navigator.pushNamed(context, '/second');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('HomeTime'),
                  content: Text(
                      'In order to access data about Hometime, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
    listViews.add(
      InkWell(
          child: HomeTimeView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 1, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (hometime == 1) {
              Navigator.pushNamed(context, '/second');
            } else {            
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('HomeTime'),
                  content: Text(
                      'In order to access data about HomeTime, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );

    //sleeptime canva

    listViews.add(
      InkWell(
          child: TitleView(
            titleTxt: 'SleepTime',
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (pedometre == 1) {
              Navigator.pushNamed(context, '/third');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('SleepTime'),
                  content: Text(
                      'In order to access data about SleepTime, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );

    listViews.add(
      InkWell(
          child: SleepListView(
            mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 3, 1.0,
                        curve: Curves.fastOutSlowIn))),
            mainScreenAnimationController: widget.animationController,
          ),
          onTap: () {
            if (sleeptime == 1) {
              Navigator.pushNamed(context, '/third');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('SleepTime'),
                  content: Text(
                      'In order to access data about SleepTime, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
/*
    listViews.add(
      TitleView(
        titleTxt: 'Body measurement',
        subTxt: 'Today',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    */
    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
    );

    //location canva

    listViews.add(
      InkWell(
          child: LocationView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 3, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (location == 1) {
              Navigator.pushNamed(context, '/fourth');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Location'),
                  content: Text(
                      'In order to access data about Location, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );

    //bluetooth canva

    listViews.add(
      InkWell(
          child: BlueView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * 3, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
          ),
          onTap: () {
            if (bluetooth == 1) {
              Navigator.pushNamed(context, '/fifth');
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Bluetooth'),
                  content: Text(
                      'In order to access data about Bluetooth, please activate the service'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration()),
                        );
                      },
                      child: Text('Go to settings'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SecondAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
