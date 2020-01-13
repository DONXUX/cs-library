import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/net/client.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/main/loan.dart';
import 'package:flutter/material.dart';

/// 인트로 화면의 동작을 담당합니다.

class IntroController extends IController {

  /// 객체를 초기화합니다.
  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    List<Book> books;
    Future.delayed(const Duration(milliseconds: 1500), () async {
      print("인트로 도서 다운로드...");
      books = await tryDownloadBooks();
      print("인트로 도서 다운완료!");
      _convertMainWidget(books);
    });
  }

  /// 도서대출 현황 화면으로 이동합니다.
  void _convertMainWidget(List<Book> books)
  => Navigator.popAndPushNamed(context, R.widget.main, arguments: books);
}