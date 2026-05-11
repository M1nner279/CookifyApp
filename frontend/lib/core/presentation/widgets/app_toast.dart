import 'app.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(bool isSuccess, String text) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      border: Border.all(
        color: Color(0xFFE5C9A8).withAlpha((0.1 * 255).toInt()),
      ),
      color: Color(0xFF2C1C16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isSuccess
            ? Icon(Icons.check, color: Color(0xFF7FB069))
            : Icon(Icons.close, color: Color(0xFFE76F51)),
        SizedBox(width: 12.0),
        Expanded(child: Text(text, style: const TextStyle(color: Color(0xFFE5C9A8)))),
      ],
    ),
  );

  fToast?.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
