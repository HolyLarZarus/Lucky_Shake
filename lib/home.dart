import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shake_gesture/shake_gesture.dart';
import 'sprüche.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  CrossFadeState _crossFade = CrossFadeState.showFirst;
  Color show_text = Colors.black;
  Random random = Random();
  String spruch = '';
  int durationtime = 350;

  void _crossFadefunction() {
    setState(() {
      if (_crossFade == CrossFadeState.showFirst) {
        durationtime = 350;
        _crossFade = CrossFadeState.showSecond;
      } else {
        durationtime = 1;
        _crossFade = CrossFadeState.showFirst;
      }

      final p1 = sprueche1[random.nextInt(sprueche1.length)];
      final p2 = sprueche2[random.nextInt(sprueche2.length)];
      final p3 = sprueche3[random.nextInt(sprueche3.length)];
      final p4 = sprueche4[random.nextInt(sprueche4.length)];
      final p5 = sprueche5[random.nextInt(sprueche5.length)];

      spruch = '$p1 $p2 $p3 $p4 $p5';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShakeGesture(
        onShake: () {
          if (_crossFade == CrossFadeState.showFirst) {
            _crossFadefunction();
          }
          setState(() {
            show_text = Colors.white;
          });
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 130,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: AutoSizeText(
              "Lucky Shake",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 80,
                fontFamily: "luck",
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedCrossFade(
                  firstChild: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset("assets/cookie.png", width: 190, height: 190),
                  ),
                  secondChild: Container(
                    height: 380,
                    width: 380,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_crossFade == CrossFadeState.showSecond) {
                            _crossFadefunction();
                          }
                          show_text = Colors.black;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 350,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(250, 250, 245, 1),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 10,
                              offset: Offset(5, 10),
                              spreadRadius: 0.05,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          spruch,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  crossFadeState: _crossFade,
                  duration: Duration(milliseconds: durationtime),
                  sizeCurve: Curves.easeInOutBack,
                ),
                Text(
                  "Shake your phone to open the fortune cookie...",
                  style: TextStyle(color: show_text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
