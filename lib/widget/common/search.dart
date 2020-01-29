import 'package:cs_book_loan/controller/common/search.dart';
import 'package:cs_book_loan/controller/main/main.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 검색관련 UI를 정리합니다.

class SearchBar extends StatelessWidget{
//  const SearchBar({
//    Key key,
//}) : super(key: key);
  MainController _mainController;
  SearchBar(MainController mainController){
    this._mainController = mainController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),

      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: SearchField(_mainController),
      )
    );
  }
}

class SearchField extends StatefulWidget {
  MainController _mainController;
  SearchField(MainController mainController) {
    this._mainController = mainController;
  }

  @override
  State<StatefulWidget> createState() => _SearchFieldState(_mainController);
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  MainController _mainController;
  _SearchFieldState(MainController mainController){
    this._mainController = mainController;
  }

  void initState(){
    super.initState();
    _focusNode.addListener((){
      if(_focusNode.hasFocus){
        _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: R.string.search,
        border: InputBorder.none,
        icon: Icon(
          Icons.search,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
//      onSubmitted: (searchQuery) {
//        BlocProvider.of<SearchBloc>(context).onSearchInitiated(searchQuery);
//      },
      controller: _controller,
      focusNode: _focusNode,
      onEditingComplete: (){
        _mainController.setSearchStr(_controller.text);
        _mainController.convertSearchListWidget(0);
        _focusNode.requestFocus(new FocusNode());
      },
    );
  }
}