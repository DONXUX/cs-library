import 'package:flutter/material.dart';
import 'package:cs_book_loan/res/lib.dart';

/// 앱을 구동할 때, 여러 초기화 메소드를 호출합니다.

abstract class Bootstrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    _init(context);
    return buildWidget(context);
  }

  /// 화면을 구성합니다.
  Widget buildWidget(BuildContext context);

  /// 여러 전역 클래스들을 초기화합니다.
  void _init(BuildContext context){
    R.initString(context);
  }
}