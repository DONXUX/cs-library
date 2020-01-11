import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/net/client.dart';
import 'package:flutter/material.dart';

/// 메인화면 동작을 담당합니다.

class MainController extends IController {
  Connect c;

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    c = Connect();
  }

  /// 책을 검색합니다.
  /// 모드 1 : 전체(도서 이름, 저자, 출판사) 검색
  /// 모드 2 : 도서 이름 검색
  /// 모드 3 : 저자 검색
  /// 모드 4 : 출판사 검색
  /// 서버로부터 도서 리스트를 다운로드한 후, 그 리스트를 검색합니다.
  List<Book> searchBook(String searchStr, int mode) {
    // 다운로드
    List<Book> allBooks = List();
    allBooks = c.tryDownloadBooks();

    // TODO : 검색 기능 구현(김학률)
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
    // TODO : 전체 검색 기능 구현(김학률)
  }
  List<Book> searchBookName(String searchStr){
    // TODO : 이름 검색 기능 구현
  }
  List<Book> searchBookAuthor(String searchStr){
    // TODO : 저자 검색 기능 구현
  }
  List<Book> searchBookPublisher(String searchStr){
    // TODO : 출판사 검색 기능 구현
  }
}