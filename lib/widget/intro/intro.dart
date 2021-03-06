import 'package:cs_book_loan/controller/intro/intro.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';
import 'package:cs_book_loan/widget/common/bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 인트로 화면을 담당합니다.

class IntroWidget extends Bootstrapper {
  final IntroController _controller = IntroController();
  @override
  Widget buildWidget(BuildContext context) {
    _controller.init(context);
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Stack(
          children: <Widget>[
            Center(

              // 로고
              child: SvgPicture.asset(R.drawable.logo,
                width: 120.0,
                height: 120.0,
                color: Colors.white,
              )
            ),
          ],
        )
      )
    );
  }
}