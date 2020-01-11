import 'package:cs_book_loan/res/lib.dart';
import 'package:cs_book_loan/res/widgets.dart';
import 'package:cs_book_loan/widget/intro/intro.dart';
import 'package:cs_book_loan/widget/main/loan.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// 앱을 구동합니다.

void main() {
  R.init();
  runApp(
    MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        canvasColor: Colors.white,
      ),
      home: IntroWidget(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ko', 'KR')
      ],
      routes: makeRoutes(R.widget),
    ));
}