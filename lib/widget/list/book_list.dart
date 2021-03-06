import 'package:cs_book_loan/controller/list/book_list.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/net/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:cs_book_loan/widget/common/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 도서 리스트 UI를 관리합니다.`

class BookListWidget extends StatefulWidget {
  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  final BookListController _controller = BookListController();
  ScrollController _scrollController;
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

  Widget AppBarWidget() {
    return AppBar(
      title: _controller.searchMode ? Text(R.string.search_result) : Text(_controller.getModeString()),
    );
  }

  Widget _EmptyListWidget() {
    return Center(
      child: Container(
        alignment:  Alignment(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.book, size: 100.0, color: Colors.black38),
            Text(R.string.not_exist_books, style: TextStyle(
              fontSize: 20.0,
              color: Colors.black38,
            ))
          ],
        ),
      ),
    );
  }

  Widget _BookListWidget() {
    return Container(
      child: ListView(
        key: PageStorageKey<String>('books'),
        children: _controller.filterBooks
            .map(_bookContents)
            .toList(),
      ),
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
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                height: 110.0,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                child: Center(
                  child: _ContentTile(book),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )
        ),
      ],
    );
  }

  Widget _ContentTile(Book book) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             // 도서 표지
             Image.network('$PROTOCOL://$HOST:$PORT/titleImg/' + book.id + '.png', width: 88.0),
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.only(left: 16.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     // 도서 제목
                     Text(
                       book.name,
                       style: headTextStyle(),
                     ),
                     // 도서 저자, 출판사, 출판년도
                     Text(
                       book.author + ", " + book.publisher + ", ${book.publish_year}",
                       style: TextStyle(
                         fontSize: 13.0,
                       ),
                     ),
                     // 대출 가능 여부
                     Text(
                       book.loan_status ? R.string.possible_loan : R.string.impossible_loan,
                       style: book.loan_status ? possibleLoanTextStyle() : impossibleLoanTextStyle(),
                     )
                   ],
                 ),
               ),
             ),
             Align(
               alignment: Alignment.centerRight,
               child: SizedBox(
                 width: 60.0,
                 child: IconButton(
                   icon: Icon(Icons.grade),
                   color: book.favorite ? Colors.amber : Colors.black38,
                   onPressed: (){
                     book.favorite ? _controller.delFavoriteBooks(book) : _controller.addFavoriteBooks(book);
                     setState((){});
                   },
                 ),
               ),
             ),
           ],
        ),
      ),
    );
  }
}