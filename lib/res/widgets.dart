import 'package:cs_book_loan/widget/intro/intro.dart';
import 'package:cs_book_loan/widget/list/book_list.dart';
import 'package:cs_book_loan/widget/main/loan.dart';
import 'package:cs_book_loan/widget/main/main.dart';
import 'package:flutter/material.dart';
import 'common.dart';

/// 위젯 리소스를 관리합니다.

class Widgets extends Resource {
  String get intro => '/intro';
  String get loan => '/loan';
  String get main => '/main';
  String get list => '/main/list';
}

// 위젯 라우터 정보입니다. 위젯을 추가하면 라우터도 추가해야합니다.
Map<String, WidgetBuilder> makeRoutes(final Widgets w) => {
  w.intro: (BuildContext context) => IntroWidget(),
  w.main: (BuildContext context) => MainWidget(),
  w.loan: (BuildContext context) => LoanWidget(),
  w.list: (BuildContext context) => BookListWidget(),
};

// 리스트 전달 매개변수 입니다.
class ListArguments {
  final int mode;
  final bool searchMode;
  final String str;

  ListArguments(this.mode, this.searchMode, this.str);
}