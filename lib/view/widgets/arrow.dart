import 'dart:math';

import 'package:dizzy/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common/value-notifiers.dart';

class Arrow extends StatefulWidget {
  @override
  _ArrowState createState() => _ArrowState();
}

class _ArrowState extends State<Arrow> {
  final List<direction> directions = [];

  int index = 0;

  @override
  void initState() {
    super.initState();
    giveRandomDirections();
  }

  giveRandomDirections() {
    Random random = Random();
    for (var i = 1; i < 15; i++) {
      directions.add(getDirection(random.nextInt(4)));
    }
    print(directions);
  }

  IconData getIconFromDirection(direction value) {
    if (value == direction.left)
      return Icons.keyboard_arrow_left;
    else if (value == direction.top)
      return Icons.keyboard_arrow_up;
    else if (value == direction.right)
      return Icons.keyboard_arrow_right;
    else
      return Icons.keyboard_arrow_down;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: rotation,
      builder: (context, value, _) {
        return AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(
            seconds: 1,
          ),
          curve: Curves.easeInOut,
          child: Icon(
            getIconFromDirection(directions[index]),
            size: 300,
            semanticLabel: "Direction",
          ),
          onEnd: () {
            index++;
          },
        );
      },
    );
  }
}
