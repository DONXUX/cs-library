import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/data/debug.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';

/// 도서 리스트 동작을 담당합니다.

class BookListController extends IController {
  List<Book> _books;
  List<Book> _debugBooks;
  int mode;
  int sort;

  Debug d;

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    _books = List();
    mode = 1;

    ////////////////////DEBUG///////////////////
    _debugBooks = List();
    d = Debug();
    _books = d.debugBook;
    /////////////////////////////////////////////
  }

  // 도서리스트를 반환합니다.
  // 도서리스트가 비어있다면 다운로드를 시도합니다.
  List<Book> get books {
    if(_books != null) return _books;
    // TODO: 다운로드
    // tryDownloadBooks();

    return _books ?? [];
  }
  /////////////////////////DEBUG///////////////////////////
  List<Book> get debugBooks {
    if(_debugBooks != null) return _debugBooks;
    // TODO: 다운로드
    // tryDownloadBooks();

    return _debugBooks ?? [];
  }
  /////////////////////////////////////////////////////////

  // 모드를 세팅합니다.
  void setMode(int mode){
    this.mode = mode;
    setListBook();
  }

  // 도서 목록을 모드에 따라 다운로드 받습니다.
  // TODO : DB와 연동하여 다운로드 구현
  /////////////////////////DEBUG///////////////////////////
  void setListBook(){
    _debugBooks.clear();
    for(var book in books){
      if(mode == 0 || book.kind == mode) {
        _debugBooks.add(book);
      }
    }
  }
  /////////////////////////////////////////////////////////
}