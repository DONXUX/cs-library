import 'package:cs_book_loan/controller/main/loan.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/common/components.dart';
import 'package:cs_book_loan/widget/common/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            Icon(Icons.book, size: 130, color: Colors.indigo),
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
      children: _CategoreyList(),
    );

  // 카테고리 리스트
  List<Widget> _CategoreyList() => [
    _CategoryContent(Icon(MdiIcons.desktopMacDashboard), "전체", 0),
    _CategoryContent(Icon(Icons.computer), "컴퓨터 공학", 2),
    _CategoryContent(Icon(MdiIcons.languageCpp), "프로그래밍 언어", 3),
    _CategoryContent(Icon(MdiIcons.cogs), "개발 방법론", 4),
    _CategoryContent(Icon(MdiIcons.ipNetwork), "네트워크/보안", 5),
    _CategoryContent(Icon(MdiIcons.brain), "인공지능", 6),
    _CategoryContent(Icon(MdiIcons.windows), "OS", 7),
    _CategoryContent(Icon(MdiIcons.database), "데이터베이스", 8),
    _CategoryContent(Icon(MdiIcons.graph), "자료구조/알고리즘", 9),
    _CategoryContent(Icon(Icons.http), "웹 프로그래밍", 10),
    _CategoryContent(Icon(Icons.phone_android), "모바일 프로그래밍", 11),
    _CategoryContent(Icon(MdiIcons.aspectRatio), "그래픽", 12),
    ];

  // 카테고리 컨텐츠 UI
  Widget _CategoryContent(final Icon icon, final String name, int mode) => GestureDetector(
    onTap: (){ _controller.convertListWidget(mode); },
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
            Text(name, style: TextStyle(fontSize: 11.0)),
          ],
        ),
      ),
  );
}



///////////////////////////////////////////////////
class DataSearch extends SearchDelegate<String> {
  final books = [
    "book1",
    "book2",
    "book3",
  ];

  final recentBooks = [
    "book1",
    "book2",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {},)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,), onPressed: (){},);
  }

  @override
  Widget buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesetionList = query.isEmpty ? recentBooks : books;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.book),
        title: Text(suggesetionList[index]),
      ),
      itemCount: suggesetionList.length,
    );
  }
}