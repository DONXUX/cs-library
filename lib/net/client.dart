import 'dart:convert';

import 'package:cs_book_loan/data/book.dart';
import 'package:http/http.dart' as http;
/// 서버와 통신을 담당합니다.

/// 서버로부터 도서 JSON 데이터를 가져옵니다.
List<Book> tryDownloadBooks() {
  // TODO : 서버로부터 도서 JSON 다운로드 구현

}

Future getData() async {
  var data;
  final response = await http.get('http://203.255.3.225:8080/searchBookAll.php');

  if(response.statusCode == 200) {
    data = json.decode(response.body);
  }
  print("json data" + data.toString());
}