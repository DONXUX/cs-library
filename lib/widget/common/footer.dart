import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(24.0),
        child: Text(
            "Copyright 2020, GNU 전산개발연구실 all rights reserved.",
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.black54,
            )
        )
    );
  }
}