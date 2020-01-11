import 'package:cs_book_loan/controller/main/main.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/common/footer.dart';
import 'package:cs_book_loan/widget/common/search.dart';
import 'package:cs_book_loan/widget/list/book_list.dart';
import 'package:cs_book_loan/widget/main/loan.dart';
import 'package:flutter/material.dart';

/// 메인화면 위젯을 담당합니다.

class MainWidget extends StatefulWidget {

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with SingleTickerProviderStateMixin {
  final MainController _controller = MainController();
  TabController ctr;

  @override
  void initState(){
    super.initState();
    ctr = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.init(context);
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: SearchBar(),
          bottom: TabBar(
            controller: ctr,
            tabs: TabWidget(),
          )
        ),
        body: TabBarView(
          controller: ctr,
          children: <Widget>[
            LoanWidget(),
            BookListWidget(1),
          ],
        )
      );
  }

  /// 탭 UI
  List<Widget> TabWidget(){
    return <Widget>[
      Tab(
        icon: Icon(Icons.book),
        text: R.string.book,
      ),
      Tab(
        icon: Icon(Icons.star),
        text: R.string.favorite,
      ),
    ];
  }

}