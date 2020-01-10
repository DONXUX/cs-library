import 'package:cs_book_loan/lib.dart';
import 'package:flutter/material.dart';

/// 각 화면의 동작을 추상화합니다.

abstract class IController {
  BuildContext _context;
  void Function(Runnable) _setState;

  void init(BuildContext context, {void Function(Runnable) setState}) async {
    this._context = context;
    this._setState = setState;
  }

  @protected
  BuildContext get context => _context;

  @protected
  void Function(Runnable) get setState => _setState;
}