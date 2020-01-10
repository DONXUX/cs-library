import 'package:cs_book_loan/widget/intro/intro.dart';
import 'package:cs_book_loan/widget/loan/loan.dart';
import 'package:flutter/material.dart';
import 'common.dart';

/// 위젯 리소스를 관리합니다.

class Widgets extends Resource {
  String get intro => '/intro';
  String get loan => '/loan';
}

// 위젯 라우터 정보입니다. 위젯을 추가하면 라우터도 추가해야합니다.
Map<String, WidgetBuilder> makeRoutes(final Widgets w) => {
  w.intro: (BuildContext context) => IntroWidget(),
  w.loan: (BuildContext context) => LoanWidget(),
};