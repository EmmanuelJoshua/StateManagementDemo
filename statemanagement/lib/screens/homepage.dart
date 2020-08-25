import 'dart:async';

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
    startTimer();
    super.initState();
  }

  startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      themeProvide = Provider.of<ThemeProvider>(context, listen: false);
      if (themeProvide.time == 0) {
        _controller..forward();
      } else {
        themeProvide.decrementTime();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
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
              builder: (context, data, child) {
                return Text(
                  'Timer: ${data.time}',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.black,
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _controller..forward();
                if (_controller.isCompleted) {
                  _controller.reverse();
                }
                themeProvide.setTime = 60;
                startTimer();
              },
            )
          ],
        ),
      ),
    );
  }
}
