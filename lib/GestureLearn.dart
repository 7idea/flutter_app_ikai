// ignore_for_file: unnecessary_const, avoid_print
import 'dart:ui';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';

class TouchControl extends StatefulWidget {
  const TouchControl({Key? key}) : super(key: key);

  @override
  TouchControlState createState() => TouchControlState();
}

class TouchControlState extends State<TouchControl> {
  List<Offset?> points = [];
  late Color selectedColor;
  late double strokeWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Color.fromRGBO(170, 17, 7, 1),
                Color.fromRGBO(246, 103, 85, 1),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 4.0)
                  ],
                ),
                child: GestureDetector(
                  onPanStart: (details) {
                    print("onPanStart ${details.localPosition}");
                    setState(() {
                      points.add(details.localPosition);
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      points.add(details.localPosition);
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      points.add(null);
                    });
                    print(points);
                  },
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20)),
                    child: CustomPaint(
                      painter: MyPainter(points: points),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.05,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.brush),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.color_lens_outlined),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ],
    );
  }

  void colorPicker(){
    
  }


  
}

// class DrawingArea {
//   Offset point;
//   Paint areaPaint;

//   DrawingArea({required this.point, required this.areaPaint});
// }

class MyPainter extends CustomPainter {
  List<Offset?> points;
  MyPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    Paint paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 2.0;
    paint.isAntiAlias = true;
    paint.strokeCap = StrokeCap.round;

    for (int x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        canvas.drawLine(points[x]!, points[x + 1]!, paint);
      } else if (points[x] != null && points[x + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[x]!], paint);
      }
    }

    // for (int x = 0; x < points.length - 1; x++) {
    //   if (points[x] != null && points[x + 1] != null) {
    //     canvas.drawLine(points[x]!, points[x + 1]!, paint);
    //   } else if (points[x] != null && points[x + 1] == null) {
    //     canvas.drawPoints(PointMode.points, [points[x]!], paint);
    //   }
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class MyCustomPainter extends CustomPainter {
//   List<Offset?> points;
//   MyCustomPainter({required this.points});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint background = Paint()..color = Colors.white;
//     Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
//     canvas.drawRect(rect, background);
//     canvas.clipRect(rect);

//     Paint paint = Paint();
//     paint.color = Colors.black;
//     paint.strokeWidth = 2.0;
//     paint.isAntiAlias = true;
//     paint.strokeCap = StrokeCap.round;

//     for (int x = 0; x < points.length - 1; x++) {
//       print("drawLine for");
//       if (points[x] != null && points[x + 1] != null) {
//         print("drawLine");
//         canvas.drawLine(points[x]!, points[x + 1]!, paint);
//       }
//       else if (points[x] != null && points[x + 1] == null) {
//         print("drawPoints");
//         canvas.drawPoints(PointMode.points, [points[x]!], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(MyCustomPainter oldDelegate) {
//     return oldDelegate.points != points;
//   }
// }
