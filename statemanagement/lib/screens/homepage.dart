import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/providers/themeprovider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  DateTime date;
  var themeProvide;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
//    startTimer();
    super.initState();
  }

//  startTimer() {
//    Timer.periodic(Duration(seconds: 1), (timer) {
//      themeProvide = Provider.of<ThemeProvider>(context, listen: false);
//      if (themeProvide.time == 0) {
//        _controller..forward();
//      } else {
//        themeProvide.decrementTime();
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/check.json',
                width: 300,
                height: 300,
                controller: _controller, onLoaded: (composition) {
              _controller..duration = composition.duration;
            }),
            SizedBox(
              height: 30,
            ),
            Consumer<ThemeProvider>(
              builder: (context, mode, widget) {
                return CupertinoSwitch(
                    value: mode.getMode,
                    trackColor:Color(0xFFAFAFA),
                    activeColor: Color(0xFFF1F1F1),
                    onChanged: (value) {
                      themeProvider.setMode = value;
                      _controller..reset();
                        _controller..forward();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
