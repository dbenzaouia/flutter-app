import '../../data/database.dart';

import '../../service/hometime.dart';
import '../second_app_theme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeTimeView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const HomeTimeView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        var _dureInHome = 0;
        var _dureHier = 0;
        var _dureAverage = 0;
        int y = HTState.todayYear();
        int m = HTState.todayMonths();
        int d = HTState.todayDay();
        List<int> dateh = DBProvider.getDateLastDay(y, m, d);
        var now = new DateTime.now();
        var _dureOutHome = 0;
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: SecondAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: SecondAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: HexColor('#87A0E5')
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                'Home',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      SecondAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: SecondAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset(
                                                      "assets/fitness_app/eaten.png"),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 3),
                                                    child: FutureBuilder<int>(
                                                        future: DBProvider()
                                                            .getHomeTimesByDay(
                                                                y,
                                                                m,
                                                                d), // a previously-obtained Future<String> or null
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            _dureInHome =
                                                                snapshot.data ~/
                                                                    3600;
                                                            return Text(
                                                              '${animatedHour(_dureInHome)}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    SecondAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: SecondAppTheme
                                                                    .darkerText,
                                                              ),
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                              'Error:\n\n${snapshot.error}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            );
                                                          } else {
                                                            return Text(
                                                                '**');
                                                          }
                                                        })),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4, bottom: 3),
                                                  child: Text(
                                                    'hours',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: SecondAppTheme
                                                          .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      letterSpacing: -0.2,
                                                      color: SecondAppTheme.grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F56E98')
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                'Outdoor',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      SecondAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: SecondAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset(
                                                      "assets/fitness_app/burned.png"),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 3),
                                                    child: FutureBuilder<int>(
                                                        future: DBProvider()
                                                            .getHomeTimesByDay(
                                                                y,
                                                                m,
                                                                d), // a previously-obtained Future<String> or null
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            _dureInHome =
                                                                snapshot.data ~/
                                                                    3600;
                                                            _dureOutHome =
                                                                now.hour -
                                                                    _dureInHome;
                                                            return Text(
                                                              '${animatedHour(_dureOutHome)}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    SecondAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: SecondAppTheme
                                                                    .darkerText,
                                                              ),
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                              'Error:\n\n${snapshot.error}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            );
                                                          } else {
                                                            return Text(
                                                                '**');
                                                          }
                                                        })),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, bottom: 3),
                                                  child: Text(
                                                    'hours',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: SecondAppTheme
                                                          .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      letterSpacing: -0.2,
                                                      color: SecondAppTheme.grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Center(
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: SecondAppTheme.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                          border: new Border.all(
                                              width: 4,
                                              color: SecondAppTheme
                                                  .nearlyDarkBlue
                                                  .withOpacity(0.2)),
                                        ),
                                        child: FutureBuilder<int>(
                                            future: DBProvider().getHomeTimesByDay(
                                                y,
                                                m,
                                                d), // a previously-obtained Future<String> or null
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                _dureInHome =
                                                    snapshot.data ~/ 3600;
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${animatedHour(_dureInHome)}h',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            SecondAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 24,
                                                        letterSpacing: 0.0,
                                                        color: SecondAppTheme
                                                            .nearlyDarkBlue,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Home',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            SecondAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        color: SecondAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                  'Error:\n\n${snapshot.error}',
                                                  textAlign: TextAlign.center,
                                                );
                                              } else {
                                                return Text(
                                                    '**');
                                              }
                                            })),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: FutureBuilder<int>(
                                          future: DBProvider().getHomeTimesByDay(
                                              y,
                                              m,
                                              d), // a previously-obtained Future<String> or null
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              _dureInHome =
                                                  snapshot.data ~/ 3600;
                                              return CustomPaint(
                                                painter: CurvePainter(
                                                    colors: [
                                                      SecondAppTheme
                                                          .nearlyDarkBlue,
                                                      HexColor("#8A98E8"),
                                                      HexColor("#8A98E8")
                                                    ],
                                                    angle: drawCircle(
                                                            _dureInHome) +
                                                        (360 - 140) *
                                                            (1.0 -
                                                                animation
                                                                    .value)),
                                                child: SizedBox(
                                                  width: 108,
                                                  height: 108,
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                'Error:\n\n${snapshot.error}',
                                                textAlign: TextAlign.center,
                                              );
                                            } else {
                                              return Text(
                                                  '**');
                                            }
                                          }))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: SecondAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Today',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: SecondAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: SecondAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: FutureBuilder<int>(
                                        future: DBProvider().getHomeTimesByDay(
                                            y,
                                            m,
                                            d), // a previously-obtained Future<String> or null
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            _dureInHome = snapshot.data ~/ 3600;
                                            return Text(
                                              '${_dureInHome}h',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    SecondAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: SecondAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                              'Error:\n\n${snapshot.error}',
                                              textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return Text(
                                                '**');
                                          }
                                        })),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Yesterday',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: SecondAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: SecondAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: FutureBuilder<int>(
                                            future: DBProvider().getHomeTimesByDay(
                                                dateh[0],
                                                dateh[1],
                                                dateh[
                                                    2]), // a previously-obtained Future<String> or null
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                _dureHier =
                                                    snapshot.data ~/ 3600;
                                                return Text(
                                                  '${_dureHier}h',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        SecondAppTheme.fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: SecondAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                  'Error:\n\n${snapshot.error}',
                                                  textAlign: TextAlign.center,
                                                );
                                              } else {
                                                return Text(
                                                    '**');
                                              }
                                            })),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Average',
                                      style: TextStyle(
                                        fontFamily: SecondAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: SecondAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: FutureBuilder<int>(
                                            future: DBProvider().getHomeTimesMean(
                                                y,
                                                m,
                                                d,
                                                30), // a previously-obtained Future<String> or null
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                _dureAverage =
                                                    snapshot.data ~/ 3600;
                                                return Text(
                                                  '${_dureAverage}h',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        SecondAppTheme.fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: SecondAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                  'Error:\n\n${snapshot.error}',
                                                  textAlign: TextAlign.center,
                                                );
                                              } else {
                                                return Text(
                                                    '**');
                                              }
                                            })),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int animatedHour(int x) {
    return (x * animation.value).toInt();
  }

  int drawCircle(int x) {
    return x * 15;
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
