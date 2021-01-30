enum direction {
  left,
  top,
  right,
  bottom,
}

direction getDirection(int value) {
  if (value == 0)
    return direction.left;
  else if (value == 1)
    return direction.top;
  else if (value == 2)
    return direction.right;
  else
    return direction.bottom;
}
