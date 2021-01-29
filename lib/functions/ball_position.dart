import 'dart:math';
import 'dart:ui';

import 'package:dizzy/common/position.dart';

Position getBallPosition({Size size, double ballSize}) {
  Random random = Random();
  Position position = Position(a: ballSize / 2, b: ballSize / 2);
  int randomX = random.nextInt(3);
  int randomY = random.nextInt(3);

  if (randomX == 0)
    position.x = ballSize / 2;
  else if (randomX == 1)
    position.x = (size.width - ballSize) / 2;
  else
    position.x = size.width - 1.5 * ballSize;

  if (randomY == 0)
    position.y = ballSize / 2;
  else if (randomY == 1)
    position.y = (size.height - ballSize) / 2;
  else
    position.y = size.height - 1.5 * ballSize;

  return position;
}
