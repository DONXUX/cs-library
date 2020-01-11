import 'package:cs_book_loan/data/book.dart';

/// 디버그용 데이터 입니다.

class Debug {
  List<Book> _debugBook;

  Debug(){
    _debugBook = List();
    Book book1 = Book(
        id: 1,
        name: "재준이는 영민이를 사랑해",
        author: "김학률",
        publisher: "구석방",
        publish_year: 2020,
        kind: 2,
        loan_possible_num: 0,
        loan_status: false
    );
    Book book2 = Book(
        id: 2,
        name: "미스터 백에게서 살아남기",
        author: "조재준",
        publisher: "실습조교실",
        publish_year: 2019,
        kind: 2,
        loan_possible_num: 1,
        loan_status: true
    );
    Book book3 = Book(
        id: 3,
        name: "학률이 조패고싶다",
        author: "권영민",
        publisher: "구석방",
        publish_year: 2018,
        kind: 3,
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
        kind: 4,
        loan_possible_num: 11,
        loan_status: true
    );

    _debugBook.add(book1);
    _debugBook.add(book2);
    _debugBook.add(book3);
    _debugBook.add(book4);
    _debugBook.add(book5);
  }

  List<Book> get debugBook => _debugBook;
}

