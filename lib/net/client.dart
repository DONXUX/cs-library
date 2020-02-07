import 'dart:async';
import 'dart:convert';

import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/net/lib.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/// 서버와 통신을 담당합니다.

/// 서버로부터 도서 JSON 데이터를 가져와 리스트 형식으로 변환합니다.
Future<List<Book>> tryDownloadBooks() async {
  /// 서버로부터 도서 JSON 파일을 가져옵니다.
  List<Book> list = List();
  var data;
  data = await onLoadBooks();
  data ??= [];

  /// JSON 파일을 도서 리스트 형식으로 변환합니다.
  list = JSONToBook(data);

  list ??= [];
  return list;
}

Future<List<dynamic>> onLoadBooks() async {
  var data;
  var response;

  response = await http.get(_composeURI(SERVER_FILE));
  if(response.statusCode == 200) {
    data = json.decode(response.body);
  }
  data ??= {};
  return data;
}

String _composeURI(final String uri){
  return '$PROTOCOL://$HOST:$PORT/$uri';
}