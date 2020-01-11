import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:flutter/material.dart';

/// 메인화면 동작을 담당합니다.

class MainController extends IController {
  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
  }

  /// 책을 검색합니다.
  /// 모드 1 : 전체(도서 이름, 저자, 출판사) 검색
  /// 모드 2 : 도서 이름 검색
  /// 모드 3 : 저자 검색
  /// 모드 4 : 출판사 검색
  List<Book> searchBook(String searchStr, int mode) {
    // TODO : 검색 기능 구현
    switch(mode){
      case 1:
        return searchBookAll(searchStr);
        break;
      case 2:
        return searchBookName(searchStr);
        break;
      case 3:
        return searchBookAuthor(searchStr);
        break;
      case 4:
        return searchBookPublisher(searchStr);
        break;
      default:
    }
  }
  List<Book> searchBookAll(String searchStr){

  }
  List<Book> searchBookName(String searchStr){

  }
  List<Book> searchBookAuthor(String searchStr){

  }
  List<Book> searchBookPublisher(String searchStr){

  }
}