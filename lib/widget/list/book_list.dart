import 'package:cs_book_loan/controller/list/book_list.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:cs_book_loan/widget/common/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 도서 리스트 UI를 관리합니다.

class BookListWidget extends StatelessWidget {
  final BookListController _controller = BookListController();
  int _category;
  bool _searchMode;
  bool _favoritesMode = false;
  String _searchStr;

  @override
  Widget build(BuildContext context) {
    final Object objArgs = ModalRoute
        .of(context)
        .settings
        .arguments;

    if(objArgs.runtimeType == ListArguments){
      ListArguments args;
      args = objArgs;
      _category = args.category;
      _searchMode = args.searchMode;
      _searchStr = args.str;
    }
    else{
      _category = 0;
      _searchMode = false;
      _searchStr = "";
      _favoritesMode = true;
    }

    _controller.init(context);
    _controller.setSearchMode = _searchMode;
    _controller.searchStr = _searchStr;
    _controller.setFavoritesMode = _favoritesMode;
    _controller.setCategory = _category;

    return Scaffold(
      appBar: _controller.favoritesMode ? null : AppBarWidget(),
      body: FutureBuilder(
        future: _controller.download().whenComplete((){ _controller.filteringBooks(); }),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator()
                );
              default:
                return _controller.filterBooks.isEmpty ? _EmptyListWidget() : _BookListWidget();
            }
          }
      ),
    );
  }

  // 도서 리스트 및 검색 리스트에 보여질 앱바입니다.
  Widget AppBarWidget() {
    return AppBar(
      title: _controller.searchMode ? Text("검색결과") : Text(_controller.getModeString()),
    );
  }

  // 도서 리스트가 없을시 나타나는 위젯입니다.
  Widget _EmptyListWidget() {
    return Center(
      child: Container(
        alignment:  Alignment(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.book, size: 100.0, color: Colors.black38),
            Text("도서가 없습니다!", style: TextStyle(
              fontSize: 20.0,
              color: Colors.black38,
            ))
          ],
        ),
      ),
    );
  }

  // 필터링된 도서 리스트 위젯입니다.
  Widget _BookListWidget() {
    return Container(
      child: ListView(
        children: _controller.filterBooks
            .map(_bookContents)
            .toList(),
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
            elevation: 2.0,
            child: Container(
              //height: 130,
              padding: EdgeInsets.all(0.0),
              child: ListTile(
                // 도서 표지
                // TODO : 도서 표지 UI 구현
                leading: Image.asset(R.drawable.sample),

                // 도서 제목
                title: Text(
                  book.name,
                  style: headTextStyle(),
                ),

                // 도서 저자, 출판사, 출판년도
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      book.author + ", " + book.publisher + ", ${book.publish_year}",
                    ),
                    Text(
                      book.loan_status ? R.string.possible_loan : R.string.impossible_loan,
                      style: book.loan_status ? possibleLoanTextStyle() : impossibleLoanTextStyle(),
                    )
                  ],
                ),
                isThreeLine: true,
                trailing: Icon(Icons.grade, color: Colors.amber),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )
        ),
      ],
    );
  }
}