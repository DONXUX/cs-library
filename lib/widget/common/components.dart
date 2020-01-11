import 'package:flutter/material.dart';

/// 자주 사용하는 컴포넌트들을 정리합니다.

///************ 자주 사용하는 텍스트 스타일 ************///
TextStyle defaultTextStyle({
  final double fontSize = 12.0,
  final int color = 0xFF000000
}) => TextStyle(
    fontSize: fontSize,
    color: Color(color),
    fontWeight: FontWeight.w200,
    fontFamily: "Roboto"
);

TextStyle headTextStyle({
  final double fontSize = 16.0,
  final int color = 0xFF000000
}) => TextStyle(
    fontSize: fontSize,
    color: Color(color),
    fontWeight: FontWeight.w600,
    fontFamily: "Roboto"
);

TextStyle impossibleLoanTextStyle({
  final double fontSize = 14.0,
}) => TextStyle(
    fontSize: fontSize,
    color: Colors.red,
    fontWeight: FontWeight.w700,
    fontFamily: "Roboto"
);

TextStyle possibleLoanTextStyle({
  final double fontSize = 14.0,
}) => TextStyle(
    fontSize: fontSize,
    color: Colors.green,
    fontWeight: FontWeight.w700,
    fontFamily: "Roboto"
);
///////////////////////////////////////////////////////////////////

///************ 배경 디자인 ************///
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width * .5, size.height - 50.0);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 80.0);
    var secondControlPoint = Offset(size.width * 0.75, size.height - 10.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }
///////////////////////////////////////////////////////////////////

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

// 탭바 동그라미 인디케이터
class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius}) : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset + Offset(cfg.size.width / 2, cfg.size.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}