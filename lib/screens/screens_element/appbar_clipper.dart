import 'package:flutter/cupertino.dart';

class AppbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 55.0);
    var firstStar = Offset((size.width / 1.3) / 2.0, size.height);
    var firstEnd = Offset(size.width / 1.3, size.height);
    path.quadraticBezierTo(
        firstStar.dx, firstStar.dy, firstEnd.dx, firstEnd.dy);
    var secondStar = Offset(size.width / 1.1, size.height);
    var secondEnd = Offset(size.width, size.height - 10.0);
    path.quadraticBezierTo(
        secondStar.dx, secondStar.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}
