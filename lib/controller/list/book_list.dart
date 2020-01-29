import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/controller/main/main.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/data/category.dart';
import 'package:cs_book_loan/data/debug.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/net/client.dart';
import 'package:cs_book_loan/net/storage.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';

/// 도서 리스트 동작을 담당합니다.

class BookListController extends IController {
  List<Book> _filterBooks;      // 필터링을 거친 리스트
  List<Book> _books;            // 서버로부터 다운받은 전체 리스트
  List<String> _favorite_books_id;
  int _category;
  bool _searchMode;
  bool _favoritesMode;
  String searchStr = "";        // 검색 문자열
  String fileName = "favorite_ids.txt";

  @override
  Future<void> init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    _filterBooks = List();
    _category = 1;
    _searchMode = false;

  }

  // setter
  set setCategory(int category) => _category = category;
  set setSearchMode(bool searchMode) => _searchMode = searchMode;
  set setFavoritesMode(bool favoritesMode) => _favoritesMode = favoritesMode;

  // getter
  get category => _category;
  get searchMode => _searchMode;
  get favoritesMode => _favoritesMode;

  // 도서리스트를 반환합니다.
  List<Book> get books {
    if(_books != null) {
      return _books;
    }
    return _books ?? [];
  }

  // 필터링을 거친 도서리스트를 반환합니다.
  List<Book> get filterBooks {
    if(_filterBooks != null) {
      return _filterBooks;
    }
    return _filterBooks ?? [];
  }

  // 리스트로부터 필요한 데이터를 다운로드 받습니다.
  // 서버로부터 도서 데이터와 파일로부터 즐겨찾기 아이디를 다운로드 받습니다.
  Future<dynamic> download() async {
    print("다운로드 진행...");
    await getFavoriteBooks();
    _books = await tryDownloadBooks();
    for(String id in _favorite_books_id){
      for(Book b in _books){
        if(b.id == id) {
          b.favorite = true;
          break;
        }
      }
      //_books[id - 1].favorite = true;
    }
    print("다운로드 완료!");
  }

  /// 책을 검색합니다.
  /// 검색 모드 1 : 전체(도서 이름, 저자, 출판사) 검색
  /// 검색 모드 2 : 도서 이름 검색
  /// 검색 모드 3 : 저자 검색
  /// 검색 모드 4 : 출판사 검색
  List<Book> searchBook(int mode) {

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

  // 검색 기능을 총괄합니다.
  List<Book> searchBookAll(){
    List<Book> searchBooks = List();
    for(Book book in _books){
      if(book.name.contains(searchStr) || book.author.contains(searchStr) || book.publisher.contains(searchStr)) {
        searchBooks.add(book);
      }
    }

    return searchBooks;
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

  // 리스트를 필터링합니다.
  Future<void> filteringBooks() async {
    _filterBooks.clear();

    // 검색 모드
    if(searchMode){
      // 검색
      if(searchStr != "") {
        _filterBooks = searchBook(1);
      }
      else {
        for (var book in _books) {
          _filterBooks.add(book);
        }
      }
      return;
    }

    // 즐겨찾기 모드
    if(favoritesMode){
      print("즐겨찾기");
      for(String idx in _favorite_books_id){
        for(Book b in _books){
          if(b.id == idx) {
            _filterBooks.add(b);
            break;
          }
        }
      }
      return;
    }

    // 카테고리 모드
    for(var book in _books) {
        if (_category == 0 || book.category == _category) {
          _filterBooks.add(book);
        }
    }
  }

  // 즐겨찾기에 해당 도서를 추가합니다.
  void addFavoriteBooks(Book book) {
    setFavoriteBooks(book);
    book.favorite = true;
  }

  // 즐겨찾기 파일을 제거합니다.
  Future<void> delFavoriteBooks(Book book) async {
      Storage file = Storage(fileName);
      _favorite_books_id = await file.readFile();
      List<String> renewList = List<String>.from(_favorite_books_id);
      int cnt = 0;
      for(String b in renewList) {
        if(b == book.id) {
          renewList.removeAt(cnt);
          break;
        }
        cnt++;
      }
    print("renewList : $renewList");
    await file.renewFile(renewList);
    book.favorite = false;
  }

  // 즐겨찾기 파일을 갱신합니다.
  Future<void> setFavoriteBooks(Book book) async {
    Storage file = Storage(fileName);
    if(!await file.writeFile(book)){
      print("데이터 갱신에 실패했습니다.");
    }
  }

  // 즐겨찾기에 등록된 도서 아이디를 가져옵니다.
  Future<void> getFavoriteBooks() async {
    Storage file = Storage(fileName);
    List<String> list = await file.readFile();
    print("가져온 데이터 : $list");
    _favorite_books_id = list;
  }

  // 즐겨찾기한 모든 책을 삭제합니다.
  Future<void> allDelFavoriteBooks() async {
    Storage file = Storage(fileName);
    file.delAllFile();
    print("즐겨찾기 데이터가 삭제되었습니다!");
  }

  // AppBar에 띄워질 스트링입니다.
  String getModeString() {
    if(_searchMode) return R.string.search_result;
    else {
      if(category != 0) return CategoryList()[category - 1].category;
      return CategoryList()[category].category;
    }
  }
}