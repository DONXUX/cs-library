import 'package:cs_book_loan/controller/main/loan.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/common/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 도서 대출 현황 화면을 담당합니다.

class LoanWidget extends StatefulWidget{
  @override
  State createState(){
    return LoanWidgetState();
  }
}

class LoanWidgetState extends State<LoanWidget> {
  final LoanController _controller = LoanController();

  @override
  Widget build(BuildContext context) {
    _controller.init(context);
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text("도서목록", textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize: 24.0)),
//                background: Container(
//                  margin: EdgeInsets.only(top:80.0),
//                  child: Container(
//                    alignment: Alignment.center,
//                    child: Text("도서 목록", textAlign: TextAlign.center, style:TextStyle(
//                      color: Colors.white,
//                      fontSize: 36.0,
//                    )),
//                  ),
//                )
              ),
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              centerTitle: true,
              expandedHeight: 180.0,
                actions: <Widget>[

                  // 검색 UI
                  IconButton(
                    icon: Icon(Icons.search, color:Colors.white),
                    onPressed: (){
                      showSearch(context: context, delegate: DataSearch());
                    },
                  )
                ]
            ),

            // 도서 리스트
            SliverList(
              delegate: SliverChildListDelegate(
                  _controller.books
                      .map(_bookContents)
                      .toList()
              ),
            ),
          ],
        )
    );
  }

  /// 도서를 UI 위젯으로 변환합니다.
  Widget _bookContents(final Book book) {

    // 책 컨텐츠
    return Stack(
      children: <Widget>[
        Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(

                  // 도서 표지
                  // TODO : 도서 표지 UI 구현
                  leading: Icon(Icons.book),

                  // 도서 제목
                  title: Text(
                    book.name,
                    style: headTextStyle(),
                  ),

                  // 도서 저자, 출판사, 출판년도
                  subtitle: Text(
                      book.author + ", " + book.publisher + ", ${book.publish_year}"
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 24.0, bottom: 8.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      // 남은 도서 수
                      Text(
                          R.string.remaining_books + " : " + "${book.loan_possible_num}" + R.string.volume
                      ),

                      // 대출 가능 여부
                      Text(
                        book.loan_status ? R.string.possible_loan : R.string.impossible_loan,
                        style: book.loan_status ? possibleLoanTextStyle() : impossibleLoanTextStyle(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          )
        ),
      ],
    );
  }
}

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