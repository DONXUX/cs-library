import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

// 내부저장소와의 통신을 담당합니다.

class Storage {
  File _jsonFile;
  Directory _dir;
  String _fileName;
  bool _fileExists;
  Map<String, dynamic> _fileContent;

  Storage(String fileName){
    _fileName = fileName;
    _fileExists = false;
    _fileContent = Map();
    getApplicationDocumentsDirectory().then((Directory directory){
      print("디버깅 : " + directory.path);
      _dir = Directory(directory.path);
      _jsonFile = new File(_dir.path + "/" + fileName);
      _fileExists = _jsonFile.existsSync();
      if(_fileExists)
        _fileContent = json.decode(_jsonFile.readAsStringSync());
    });
  }

  void createFile(Map<String, String> content){
    print("파일이 생성되었습니다!");
    File file = new File(_dir.path + "/" + _fileName);
    file.createSync();
    _fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value){
    print("파일을 기록합니다.");
    Map<String, dynamic> content = {key: value};
    if(_fileExists) {
      Map<String, dynamic> jsonFileContent = json.decode(_jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      _jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("파일이 존재하지 않습니다. 파일을 생성합니다...");
      createFile(content);
    }
    _fileContent = json.decode(_jsonFile.readAsStringSync());
    print(_fileContent);
  }
}