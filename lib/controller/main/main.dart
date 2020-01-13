import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/net/client.dart';
import 'package:cs_book_loan/net/file.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:cs_book_loan/widget/common/alert.dart';
import 'package:flutter/material.dart';

/// 메인화면 동작을 담당합니다.

class MainController extends IController {
  String searchStr = "";
  FileInfo file;
  List<Book> books;

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
  }

  // 검색 텍스트 필드로부터 Input 데이터를 가져옵니다.
  void setSearchStr(String str){
    searchStr = str;
  }

  // 검색 리스트 위젯으로 전환합니다.
  void convertSearchListWidget(int mode)
  => Navigator.pushNamed(context, R.widget.list, arguments: ListArguments(mode, true, searchStr));

  /// 사용자가 메인화면에서 뒤로가기 버튼을 누른 경우의 이벤트입니다.
  /// 앱을 종료할 것인지 물어봅니다.
  Future<bool> onBackPressed() async {
    return dialogExit(context);
  }
}