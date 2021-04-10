// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../model/position.dart';

ValueNotifier<String> foundText = ValueNotifier<String>("searching");
ValueNotifier<bool> hasStarted = ValueNotifier<bool>(false);
ValueNotifier<double> lastRecorded = ValueNotifier<double>(null);

ValueNotifier<int> counter = ValueNotifier<int>(0);
ValueNotifier<Position> position = ValueNotifier<Position>(
  Position(
    a: 15,
    b: 15,
  ),
);
