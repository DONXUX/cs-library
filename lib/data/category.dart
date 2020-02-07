import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// 카테고리 데이터를 관리합니다.

class Category {
  Icon _icon;
  String _category;
  int _key;

  Category(Icon icon, String category, int key) {
    _icon = icon;
    _category = category;
    _key = key;
  }

  Icon get icon => _icon;
  String get category => _category;
  int get key => _key;
}

// 카테고리 리스트 { 아이콘, 카테고리 이름, 고유 키 값 }
List<Category> CategoryList() => [
  Category(Icon(MdiIcons.desktopMacDashboard), R.string.category_all, 0),
  Category(Icon(Icons.computer), R.string.category_computer_engineering, 2),
  Category(Icon(MdiIcons.languageCpp), R.string.category_programming_lang, 3),
  Category(Icon(MdiIcons.cogs), R.string.category_development_methodology, 4),
  Category(Icon(MdiIcons.ipNetwork), R.string.category_network, 5),
  Category(Icon(MdiIcons.brain), R.string.category_ai, 6),
  Category(Icon(MdiIcons.windows), R.string.category_os, 7),
  Category(Icon(MdiIcons.database), R.string.category_db, 8),
  Category(Icon(MdiIcons.graph), R.string.category_algorithm, 9),
  Category(Icon(Icons.http), R.string.category_web, 10),
  Category(Icon(Icons.phone_android), R.string.category_mobile, 11),
  Category(Icon(MdiIcons.aspectRatio), R.string.category_graphics, 12),
];

