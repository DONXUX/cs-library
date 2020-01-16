import 'package:meta/meta.dart';

/// 도서에 대한 자세한 정보를 담고 있는 클래스입니다.
/// { ID, 도서 이름, 저자, 출판사, 출판년도, 종류, 남은 갯수, 대출 가능상태 }로 이루어져 있습니다.

class Book {
  final int id;
  final String name;
  final String author;
  final String publisher;
  final int publish_year;
  final int category;
  final int loan_possible_num;
  final bool loan_status;
  bool favorite;

  Book({
    @required this.id,
    @required this.name,
    @required this.author,
    @required this.publisher,
    @required this.publish_year,
    @required this.category,
    @required this.loan_possible_num,
    @required this.loan_status,
    }): assert(id != null),
        assert(name != null),
        assert(author != null),
        assert(publisher != null),
        assert(publish_year != null),
        assert(category != null),
        assert(loan_possible_num != null),
        assert(loan_status != null);
}

