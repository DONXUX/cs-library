import 'package:cs_book_loan/lib.dart';
import 'package:cs_book_loan/res/lib.dart';
import 'package:flutter/material.dart';

void dialog(final BuildContext context, final String msgId,
    { Runnable onConfirm, Runnable onCancel }) {
  onCancel == null
      ? _dialogSimple(context, msgId, onConfirm: onConfirm)
      : _dialogAsk(context, msgId, onConfirm: onConfirm, onCancel: onCancel);
}

/// 확인 버튼 하나있는 간단한 알림창을 띄웁니다.
void _dialogSimple(final BuildContext context, final String msg,
    { Runnable onConfirm }) async => showDialog(context: context,
  barrierDismissible: onConfirm == null,
  builder: (BuildContext context) => WillPopScope(
    onWillPop: () async => _onWillPop(onConfirm),
    child: AlertDialog(
      title: Text(R.string.common_alert_title),
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
            child: Text(R.string.common_alert_confirm),
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) onConfirm();
            }
        ),
      ],
    ),
  ),
);

/// 종료 알림창을 띄웁니다.
Future<bool> dialogExit(final BuildContext context) async {
  _dialogAsk(context, R.string.common_alert_field_close_app, onConfirm: exit);
  return false;
}

/// 예, 아니오 버튼이 있는 알림창을 띄웁니다.
void _dialogAsk(final BuildContext context, final String msg,
    { Runnable onConfirm, Runnable onCancel }) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => WillPopScope(
    onWillPop: () async => _onWillPop(onCancel),
    child: AlertDialog(
      title: Text(R.string.common_alert_title),
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
            child: Text(R.string.common_alert_choose_yes),
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) onConfirm();
            }
        ),
        FlatButton(
            child: Text(R.string.common_alert_choose_no),
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel();
            }
        ),
      ],
    ),
  ),
);


/// 알림창에서 뒤로가기 버튼을 누른 경우의 이벤트입니다.
/// 정의한 취소 메소드를 수행하고 알림창을 종료합니다.
Future<bool> _onWillPop(final Runnable onDismiss) async {
  if (onDismiss != null) onDismiss();
  return true;
}