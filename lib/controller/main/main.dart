import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/net/client.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:flutter/material.dart';

/// 메인화면 동작을 담당합니다.

class MainController extends IController {
  Connect c;
  String searchStr = "";

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
    c = Connect();
  }

  // 검색 텍스트 필드로부터 Input 데이터를 가져옵니다.
  void setSearchStr(String str){
    searchStr = str;
  }

  // 검색 리스트 위젯으로 전환합니다.
  void convertSearchListWidget(int mode)
  => Navigator.pushNamed(context, R.widget.list, arguments: ListArguments(mode, true, searchStr));
}