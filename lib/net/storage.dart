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

  // JSON 파일을 기록합니다.
  Future<bool> writeFile(Book content) async {
    List<int> books_id_list = List();
    List<int> books_id_list_add = List();
    final file = await _localFile;
    books_id_list = await readFile();
    for(int i in books_id_list) {
      if(i == content.id)
        return false;
    }

    books_id_list_add = List<int>.from(books_id_list);
    books_id_list_add.add(content.id);
    print("books_id_list : $books_id_list_add");

    await renewFile(books_id_list_add);
    return true;
  }

  // JSON 파일을 가져와 해석합니다.
  Future<List<int>> readFile() async {
    List<int> contents;
    try {
      final file = await _localFile;
      contents = utf8.encode(file.readAsStringSync());
      print("컨텐츠 : $contents");

      return contents;
    } catch (e) {
      print("데이터가 존재하지 않습니다. 파일을 생성합니다...");
      print("에러내용 : $e");
      return [];
    }
  }

  // JSON 파일을 삭제합니다.
  Future<List<Book>> delAllFile() async {
    final file = await _localFile;
    file.deleteSync(recursive: true);
  }

  // JSON 파일을 갱신합니다.
  Future<void> renewFile(List<int> books_id) async {
    final file = await _localFile;

    // 파일을 갱신합니다.
    try {
      file.writeAsStringSync(utf8.decode(books_id));
      print(file.path + "에 '$name' 파일이 갱신되었습니다!");
    } catch(e) {
      print("오류 : 파일이 갱신되지 않았습니다.");
      print("에러내용 : $e");
    }
  }
}