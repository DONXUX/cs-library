import 'package:cs_book_loan/controller/loan/loan.dart';
import 'package:cs_book_loan/data/book.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/widget/common/components.dart';
import 'package:flutter/material.dart';

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

      // 앱 바
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          R.string.book_list,
          style: TextStyle(
              fontSize: 22.0,
              color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search, color:Colors.white),
          )
        ]
      ),

        body: Stack(
          children: <Widget>[

            // 배경
            ClipPath(
              clipper: CustomShapeClipper(),
              child: AnimatedContainer(
                height: 350.0,
                color: Colors.indigo,
                duration: Duration(milliseconds: 1300),
              ),
            ),

            // 도서 리스트
            SingleChildScrollView(
              child: Container(
                child: Center(
                    child: Column(
                      children: _controller.books
                          .map(_bookContents)
                          .toList(),
                    )
                ),
              ),
            ),
          ],
        )
    );
  }

  /// 도서를 UI 위젯으로 변환합니다.
  Widget _bookContents(final Book book) {

    /// 책 컨텐츠
    return Stack(
      children: <Widget>[
        Card(
            margin: EdgeInsets.all(8.0),
            elevation: 8.0,
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
                  margin: EdgeInsets.only(top: 24.0, bottom: 8.0, left: 8.0, right: 8.0),
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