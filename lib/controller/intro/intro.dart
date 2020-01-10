import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/loan/loan.dart';
import 'package:flutter/material.dart';

/// 인트로 화면의 동작을 담당합니다.

class IntroController extends IController {

  /// 객체를 초기화합니다.
  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);

    Future.delayed(const Duration(milliseconds: 1500), () {
      _convertLoanWidget();
    });
  }

  /// 도서대출 현황 화면으로 이동합니다.
  void _convertLoanWidget() => Navigator.popAndPushNamed(context, R.widget.loan);
}