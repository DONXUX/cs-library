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
  int _mode;
  bool _searchMode;
  bool _favoritesMode = false;
  String _searchStr;

  @override
  Widget build(BuildContext context) {
    final ListArguments args = ModalRoute
        .of(context)
        .settings
        .arguments;
    print("args 디버깅" + args.toString());

    if(args != null) {
      _mode = args.category;
      _searchMode = args.searchMode;
      _searchStr = args.str;
    }
    else{
      _mode = 0;
      _searchMode = false;
      _searchStr = "";
      _favoritesMode = true;
    }
    print("디버깅 : " + _searchStr);

    _controller.init(context);
    _controller.searchMode = _searchMode;
    _controller.searchStr = _searchStr;
    _controller.favoritesMode = _favoritesMode;
    _controller.setCategory(_mode);

    return Scaffold(
      body: Container(
        child: ListView(
          children: _controller.debugBooks
              .map(_bookContents)
              .toList(),
        ),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(

                  // 도서 표지
                  // TODO : 도서 표지 UI 구현
                  leading: Icon(Icons.book, size: 70.0),

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
              borderRadius: BorderRadius.circular(8.0),
            )
        ),
      ],
    );
  }
}