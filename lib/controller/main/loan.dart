import 'dart:core';

import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:cs_book_loan/widget/main/loan.dart';
import 'package:flutter/material.dart';
import "dart:math";

/// 도서 플래그먼트 동작을 담당합니다.

class LoanController extends IController {
  List<Book> _books;
  int _maxEndorseNum = 7;
  /// 객체를 초기화합니다.
  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
  }

  set setBooks(List<Book> books) => _books;

  // 도서 리스트 화면으로 전환합니다.
  void convertListWidget(int category)
  => Navigator.pushNamed(context, R.widget.list, arguments: ListArguments(category, false, ""));

  // 도서 리스트 일부를 랜덤으로 뽑습니다.
  List<Book> getEndorseBooks(List<Book> books){
    if(books.length < _maxEndorseNum)
      _maxEndorseNum = books.length;

    List<Book> recommed_books = List();
    books.shuffle();
    for(var i = 0; i < _maxEndorseNum; i++) {
      Book element = books[i];
      recommed_books.add(element);
    }

    return recommed_books;
  }
}