import 'package:flutter/material.dart';
import '../second_app_theme.dart';

class BlueView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const BlueView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 0),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: SecondAppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: SecondAppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                child: SizedBox(
                                  height: 74,
                                  child: AspectRatio(
                                    aspectRatio: 1.714,
                                    child: Image.asset(
                                        "assets/fitness_app/back.png"),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 100,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Discover your usage ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    SecondAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                color: SecondAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              "of connected objects",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    SecondAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                color: SecondAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 12,
                                      top: 4,
                                      right: 16,
                                    ),
                                    /* child: Text(
                                      "Vous avez dépassez la durée d'activité\nphysique hebdomadaire recommandée par l'ONU!",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SecondAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 0.0,
                                        color: SecondAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ), */
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -16,
                        left: 0,
                        child: SizedBox(
                          width: 110,
                          height: 110,
                          child: Icon(
                            Icons.bluetooth_audio,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
