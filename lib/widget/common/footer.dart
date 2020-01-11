import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(24.0),
        child: Text(
            R.string.copyright,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.black54,
            )
        )
    );
  }
}