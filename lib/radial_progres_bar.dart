import 'dart:math';
import 'dart:ui';
import 'package:vector_math/vector_math_64.dart' as math;

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double goalCompleted = 0.7;

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  double progress = 0.0;
  double invertProgress = 360.0;
  /*
  x - aktualana wartosc
  */
  double x;

  @override
  void initState() {
    super.initState();

    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    double screenSize =
        min(window.physicalSize.width / 2, window.physicalSize.height / 2) + 90;
    setState(() {
      if (progress < 360.0) {
        progress = progress + 0.5;
      } else {
        progress = 0.0;
      }
      invertProgress = 360.0 - progress;
//      var jakas = (x - 0) * (10 - 0) / (360 - 0) + 0;

    });
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: CustomPaint(
        //todo sprobowac zrobic cos z Extended + padding dla Conteiner
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  '$progress',
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),

              ),
              Center(child: Text('$invertProgress', style: TextStyle(color: Colors.red, fontSize: 22.0),),),
            ],
          ),
//        height: screenSize,
//        width: screenSize,
        ),
        painter: RadiusPainter(progress),
      ),
    );
  }
}

class RadiusPainter extends CustomPainter {
  RadiusPainter(this.progressInDegrees);

  double progressInDegrees;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black26
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progresPaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.redAccent, Colors.greenAccent, Colors.blueAccent])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progresPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
