class Position {
  int x;
  int y;

  Position({required this.x, required this.y});

  void setPosition({required int x, required int y}) {
    this.x = x;
    this.y = y;
  }

  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
