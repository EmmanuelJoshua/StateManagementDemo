import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/modals/circular_modal.dart';
import 'package:statemanagement/modals/modal_fit.dart';
import 'package:statemanagement/modals/modal_inside_modal.dart';
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
                    trackColor: Color(0xFFAFAFA),
                    activeColor: Color(0xFFF1F1F1),
                    onChanged: (value) {
                      themeProvider.setMode = value;
                      _controller..reset();
                      _controller..forward();
                    });
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 55,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GradientBorderButtonContainer(
                  onPressed: () => showAvatarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context, scrollController) =>
                        ModalInsideModal(scrollController: scrollController),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.2),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.4,
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                      child: Container(
                        child: Center(child: Text('Show Modal')),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GradientPainter extends CustomPainter {
  GradientPainter({this.gradient, this.strokeWidth});
  final Gradient gradient;
  final double strokeWidth;
  final Paint paintObject = Paint();
  @override
  void paint(Canvas canvas, Size size) {
    Rect innerRect = Rect.fromLTRB(strokeWidth, strokeWidth,
        size.width + strokeWidth, size.height + strokeWidth);
    Rect outerRect = Offset.zero & size;
    paintObject.shader = gradient.createShader(outerRect);
    Path borderPath = _calculateBorderPath(outerRect, innerRect);
    canvas.drawPath(borderPath, paintObject);
  }

  Path _calculateBorderPath(Rect outerRect, Rect innerRect) {
    Path outerRectPath = Path()..addRect(outerRect);
    Path innerRectPath = Path()..addRect(innerRect);
    return Path.combine(PathOperation.difference, outerRectPath, innerRectPath);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class GradientBorderButtonContainer extends StatelessWidget {
  GradientBorderButtonContainer({
    @required gradient,
    @required this.child,
    this.strokeWidth = 2.5,
    this.onPressed,
  }) : this.painter =
            GradientPainter(gradient: gradient, strokeWidth: strokeWidth);
  final GradientPainter painter;
  final Widget child;
  final VoidCallback onPressed;
  final double strokeWidth;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: painter, child: child);
  }
}
