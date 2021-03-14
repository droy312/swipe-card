import 'dart:math';

import 'package:flutter/material.dart';

/// [list] is a list of widgets
/// [dragLength] is the length to be dragged to dismiss the current top widget
class SwipeCard extends StatefulWidget {
  final List<Widget> widgetList;
  final double dragLength;
  SwipeCard({Key? key, this.dragLength: 200, this.widgetList: const []})
      : super(key: key);

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  List<Widget> list = [];

  Offset dragStartPoint = Offset(0, 0);
  Offset dragPoint = Offset(0, 0);
  double diff = 0;
  int index = 0;
  double dragLength = 0;

  double rotationAngle = 0;

  double angle(double diff) {
    return (diff / dragLength) * pi;
  }

  double calDiff(Offset dragStartPoint, Offset dragPoint) {
    double diffY = dragPoint.dy - dragStartPoint.dy;
    if (diffY > 0)
      return 0;
    else {
      if (diffY <= -1 * dragLength) {
        return -1 * dragLength;
      }
      return diffY;
    }
  }

  List<Widget> revList(List<Widget> list) {
    List<Widget> revList = [];
    for (int i = list.length - 1; i >= 0; i--) {
      revList.add(list[i]);
    }
    return revList;
  }

  @override
  void initState() {
    super.initState();

    dragLength = widget.dragLength.abs();

    list = revList(widget.widgetList);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      rotationAngle = angle(diff);
    });

    return Stack(
      children: list.asMap().entries.map((w) {
        return GestureDetector(
          onHorizontalDragStart: (details) {
            setState(() {
              index = w.key;
              dragStartPoint = details.localPosition;
              diff = 0;
            });
          },
          onHorizontalDragUpdate: (details) {
            setState(() {
              dragPoint = details.localPosition;
              diff = calDiff(dragStartPoint, dragPoint);
            });
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              if (diff <= -1 * dragLength) {
                final Widget widget = list.removeAt(index);
                list.insert(0, widget);
              }
              dragStartPoint = Offset(0, 0);
              dragPoint = Offset(0, 0);
              diff = calDiff(dragStartPoint, dragPoint);
            });
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, .001)
              ..rotateX(
                (index == w.key) ? rotationAngle : 0,
              ),
            alignment: FractionalOffset.topCenter,
            child: Opacity(
              opacity:
                  (index == w.key) ? 1 - (diff.abs() / dragLength) : 1,
              child: w.value,
            ),
          ),
        );
      }).toList(),
    );
  }
}
