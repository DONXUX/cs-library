import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/data/debug.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/net/client.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';

/// 도서 리스트 동작을 담당합니다.

class BookListController extends IController {
  List<Book> _books;      // 필터링을 거친 리스트
  List<Book> _allBooks;   // 서버로부터 다운받은 전체 리스트
  List<Book> _debugBooks;   // DEBUG (디버그용 필터링을 거친 리스트, 전체리스트는 books가 됨)
  Connect c;
  int mode;
  int sort;
  bool searchMode;
  bool favoritesMode;
  String searchStr = "";    // 검색 문자열

  Debug d;

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    _books = List();
    _allBooks = List();
    mode = 1;
    searchMode = false;

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
    // 다운로드
    // _allBooks = c.tryDownloadBooks();
    return _books ?? [];
  }

  // 카테고리 모드를 세팅합니다.
  void setMode(int mode){
    this.mode = mode;
    setListBook();
  }

  /// 책을 검색합니다.
  /// 검색 모드 1 : 전체(도서 이름, 저자, 출판사) 검색
  /// 검색 모드 2 : 도서 이름 검색
  /// 검색 모드 3 : 저자 검색
  /// 검색 모드 4 : 출판사 검색
  /// 서버로부터 도서 리스트를 다운로드한 후, 그 리스트를 검색합니다.
  List<Book> searchBook(int mode) {
    // 다운로드
    ///////////////요거는 DB 연동 후 쓰일예정/////////////////
    // _allBooks = c.tryDownloadBooks();
    /////////////////////////////////////////////////////////////

    // TODO : 검색 기능 구현(김학률)
    switch(mode){
      case 1:
        return searchBookAll();
        break;
      case 2:
        return searchBookName();
        break;
      case 3:
        return searchBookAuthor();
        break;
      case 4:
        return searchBookPublisher();
        break;
      default:
    }
  }

  List<Book> searchBookAll(){
    // TODO : 전체 검색 기능 구현(김학률)
    // 이름, 저자, 출판사 전체 검색하여 리스트로 저장한다.
    // DB 연동되기전엔 books가 전체 리스트이다.
    // searchStr 문자열로
    // books 리스트를 필터링 하여야함.
    List<Book> filterBooks = List();
    for(Book book in books){
      if(book.name.contains(searchStr) || book.author.contains(searchStr) || book.publisher.contains(searchStr)) {
        filterBooks.add(book);
      }
    }
    
    return filterBooks;
  }
  List<Book> searchBookName(){
    // TODO : 이름 검색 기능 구현
  }
  List<Book> searchBookAuthor(){
    // TODO : 저자 검색 기능 구현
  }
  List<Book> searchBookPublisher(){
    // TODO : 출판사 검색 기능 구현
  }

  /////////////////////////DEBUG///////////////////////////
  List<Book> get debugBooks {
    if(_debugBooks != null) return _debugBooks;
    return _debugBooks ?? [];
  }

  void setListBook(){
    _debugBooks.clear();
    // 검색 모드
    print("디버깅 안 : " + searchStr);

    if(searchMode){
      // 검색
      if(searchStr != "") {
        _books = searchBook(1);
      }
      print(_books);
      for(var book in books) {
        _debugBooks.add(book);
      }
      return;
    }

    // 즐겨찾기 모드
    if(favoritesMode){
      print("즐겨찾기");
      // TODO : 즐겨찾기 모드 구현
    }

    // 카테고리 모드
    for(var book in books){
      if(mode == 0 || book.kind == mode) {
        _debugBooks.add(book);
      }
    }
  }
  /////////////////////////////////////////////////////////



}