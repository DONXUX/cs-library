import 'dart:convert';

import 'package:cs_book_loan/controller/main/loan.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/common/components.dart';
import 'package:cs_book_loan/widget/common/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cs_book_loan/data/category.dart';
import 'package:http/http.dart' as http;
/// 도서 플래그먼트 위젯을 담당합니다.

class LoanWidget extends StatelessWidget {
  final LoanController _controller = LoanController();

  @override
  Widget build(BuildContext context) {
    _controller.init(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _GuideLoan(),
                _CategoreyWidget(),
                _RecommenderBookWidget(),
                Footer(),
              ],
            )
          ),
        )
    );
  }

  // 도서 대출 가이드 컨테이너
  Widget _GuideLoan() => Container(
    height: 42.0,
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.black12,
          )
      )
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8.0),
            child: Container(child: Icon(Icons.book, color: Colors.black54)),
          ),
          Text(R.string.guide,
              style: TextStyle(fontSize: 13.0, color: Colors.black54)),
        ],
      ),
    )
  );

  // 추천도서 UI
  Widget _RecommenderBookWidget() => Column(
      children: <Widget>[
        Text(
            "추천 도서",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _RecommendedBookList(),
          )
        )
      ],
    );

  // 추천도서 리스트
  List<Widget> _RecommendedBookList() => [
      _RecommendedBookContent(),
      _RecommendedBookContent(),
      _RecommendedBookContent(),
      _RecommendedBookContent(),
    ];

  // 추천도서 컨텐츠 UI
  Widget _RecommendedBookContent() => Card(
      elevation: 1.0,
      margin: EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0, bottom: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(R.drawable.sample, width:102, height: 142),
            Text("제목", style: headTextStyle()),
            Text("저자", style: defaultTextStyle()),
            Text("출판사", style: defaultTextStyle()),
          ],
        ),
      ),
    );

  // 카테고리 UI
  Widget _CategoreyWidget() => GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      padding: EdgeInsets.only(bottom: 16.0),
      children: _getCategoryListToWidget(),
    );

  // 카테고리 리스트를 위젯으로 변환합니다.
  List<Widget> _getCategoryListToWidget() {
    List<Widget> list = List();
    for(Category c in CategoryList()) {
      list.add(_CategoryContent(c.icon, c.category, c.key));
    }
    return list;
  }

  // 카테고리 컨텐츠 UI
  Widget _CategoryContent(final Icon icon, final String category, int key) => GestureDetector(
    onTap: (){ _controller.convertListWidget(key); },
    child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            Text(category, style: TextStyle(fontSize: 11.0)),
          ],
        ),
      ),
  );
}

