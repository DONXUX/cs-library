import 'dart:core';

import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:cs_book_loan/widget/main/loan.dart';
import 'package:flutter/material.dart';

/// 도서 플래그먼트 동작을 담당합니다.

class LoanController extends IController {

  /// 객체를 초기화합니다.
  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
  }

  // 도서 리스트 화면으로 전환합니다.
  void convertListWidget(int category)
  => Navigator.pushNamed(context, R.widget.list, arguments: ListArguments(category, false, ""));
}