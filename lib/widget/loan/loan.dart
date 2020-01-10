import 'package:cs_book_loan/controller/loan/loan.dart';
import 'package:flutter/material.dart';

/// 도서 대출 현황 화면을 담당합니다.

class LoanWidget extends StatelessWidget{
  final LoanController _controller = LoanController();

  @override
  Widget build(BuildContext context) {
    _controller.init(context);
    return Scaffold(
        body: Container(
          // TODO : 도서대출 현황 UI 구성
          child: Center(child: Text("도서 대출 화면")),
        )
    );
  }

}