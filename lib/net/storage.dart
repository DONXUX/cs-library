import 'dart:io';
import 'dart:convert';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/net/lib.dart';
import 'package:path_provider/path_provider.dart';

// 내부저장소와의 통신을 담당합니다.

class Storage {
  String _name;

  Storage(String name) {
    _name = name;
  }

  String get name => _name;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/' + name);
  }

  // 파일을 기록합니다.
  Future<bool> writeFile(Book content) async {
    List<String> books_id_list = List();
    List<String> books_id_list_add = List();
    books_id_list = await readFile();
    for(String i in books_id_list) {
      if(i == content.id)
        return false;
    }

    books_id_list_add = List<String>.from(books_id_list);
    books_id_list_add.add(content.id);

    await renewFile(books_id_list_add);
    return true;
  }

  // 파일을 가져와 해석합니다.
  Future<List<String>> readFile() async {
    try {
      final file = await _localFile;
      List<String> contents;
      contents = await file.readAsStringSync().split(" ");

      return contents;
    } catch (e) {
      print("데이터가 존재하지 않습니다. 파일을 생성합니다...");
      print("에러내용 : $e");
      return [];
    }
  }

  // 파일을 삭제합니다.
  Future<List<Book>> delAllFile() async {
    final file = await _localFile;
    file.deleteSync(recursive: true);
  }

  // 파일을 갱신합니다.
  Future<void> renewFile(List<String> books_id) async {
    final file = await _localFile;

    try {
      String row_data = "";
      for(String book_id in books_id){
        if(book_id == "") continue;
        row_data += book_id + " ";
      }
      file.writeAsStringSync(row_data);
      print(file.path + "에 '$name' 파일이 갱신되었습니다!");
    } catch(e) {
      print("오류 : 파일이 갱신되지 않았습니다.");
      print("에러내용 : $e");
    }
  }
}