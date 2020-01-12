import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  Category(Icon(MdiIcons.desktopMacDashboard), "전체", 0),
  Category(Icon(Icons.computer), "컴퓨터 공학", 2),
  Category(Icon(MdiIcons.languageCpp), "프로그래밍 언어", 3),
  Category(Icon(MdiIcons.cogs), "개발 방법론", 4),
  Category(Icon(MdiIcons.ipNetwork), "네트워크/보안", 5),
  Category(Icon(MdiIcons.brain), "인공지능", 6),
  Category(Icon(MdiIcons.windows), "OS", 7),
  Category(Icon(MdiIcons.database), "데이터베이스", 8),
  Category(Icon(MdiIcons.graph), "자료구조/알고리즘", 9),
  Category(Icon(Icons.http), "웹 프로그래밍", 10),
  Category(Icon(Icons.phone_android), "모바일 프로그래밍", 11),
  Category(Icon(MdiIcons.aspectRatio), "그래픽", 12),
];

