class Position {
  double x;
  double y;
  DateTime time;

  Position({double a, double b, DateTime t}) {
    x = a;
    y = b;
    time = t;
  }

  setPosition({double a, double b}) {
    x = a;
    y = b;
  }
}
