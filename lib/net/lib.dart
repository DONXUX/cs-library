import 'package:cs_book_loan/data/book.dart';

/// 통신 관련 상수입니다.
const String PROTOCOL = 'http';
const String HOST = '203.255.3.225';
const String PORT = "8080";
const String SERVER_FILE = "searchBookAll.php";

// 데이터 컨버터
// 도서 데이터를 JSON 데이터로 변환합니다.
List<Map<String, String>> BookToJSON(List<Book> books) {
  List<Map<String, String>> jsons = List();

  for(var book in books){
    Map<String, String> j = {
      "idx": book.id.toString(),
      "name": book.name,
      "author": book.author,
      "publisher": book.publisher,
      "year": book.publish_year.toString(),
      "category": book.category.toString(),
      "borrowstate": book.loan_status ? "1" : "0",
    };
    jsons.add(j);
  }
  return jsons;
}

// JSON 데이터를 도서 데이터로 변환합니다.
List<Book> JSONToBook(List<dynamic> jsons) {
  List<Book> books = List();
  for(var json in jsons){
    Book b = Book(
      id: int.parse(json['idx']),
      name: json['name'],
      author: json['author'],
      publisher: json['publisher'],
      publish_year: int.parse(json['year']),
      category: int.parse(json['category']),
      loan_possible_num: 3,
      loan_status: json['borrowstate'] == '1' ? true : false,
    );
    b.favorite = false;
    books.add(b);
  }
  return books;
}