import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';

/// 도서 리스트 동작을 담당합니다.

class BookListController extends IController {
  List<Book> _books;
  int mode;
  int sort;

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    _books = List();

    /////// 디버깅용 샘플 데이터 ///////
    Book book1 = Book(
        id: 1,
        name: "재준이는 영민이를 사랑해",
        author: "김학률",
        publisher: "구석방",
        publish_year: 2020,
        kind: 1,
        loan_possible_num: 0,
        loan_status: false
    );
    Book book2 = Book(
        id: 2,
        name: "미스터 백에게서 살아남기",
        author: "조재준",
        publisher: "실습조교실",
        publish_year: 2019,
        kind: 1,
        loan_possible_num: 1,
        loan_status: true
    );
    Book book3 = Book(
        id: 3,
        name: "학률이 조패고싶다",
        author: "권영민",
        publisher: "구석방",
        publish_year: 2018,
        kind: 1,
        loan_possible_num: 0,
        loan_status: false
    );
    Book book4 = Book(
        id: 4,
        name: "훈남 이동욱 따라잡기",
        author: "이동욱",
        publisher: "구석방",
        publish_year: 2020,
        kind: 1,
        loan_possible_num: 0,
        loan_status: false
    );
    Book book5 = Book(
        id: 5,
        name: "영민이 후장주름처럼",
        author: "권땡땡",
        publisher: "구석방",
        publish_year: 2018,
        kind: 1,
        loan_possible_num: 11,
        loan_status: true
    );
    ////////////////////////////
    _books.add(book1);
    _books.add(book2);
    _books.add(book3);
    _books.add(book4);
    _books.add(book5);
  }

  // 도서리스트를 반환합니다.
  // 도서리스트가 비어있다면 다운로드를 시도합니다.
  List<Book> get books {
    if(_books != null) return _books;
    // TODO: 다운로드
    // tryDownloadBooks();
    return _books ?? [];
  }

  // 모드를 세팅합니다.
  void setMode(int mode){
    this.mode = mode;
  }

  // 도서 목록을 모드에 따라 다운로드 받습니다.
  // TODO : DB와 연동하여 다운로드 구현
  void setListBook(){
    books.clear();
    for(Book book in books){
      if(book.kind == mode) {
        _books.add(book);

      }
    }
  }

}