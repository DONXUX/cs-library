import 'package:cs_book_loan/controller/lib.dart';
import 'package:cs_book_loan/lib.dart';
import 'package:flutter/material.dart';

class SearchController extends IController {
  String input;

  @override
  void init(BuildContext context, {void Function(Runnable) setState}) async {
    super.init(context, setState: setState);
  }
}