import 'package:flutter/material.dart';

class ToastDialog {
  static const int _duration = 3;
  static const double _fontSize = 16.0;
  static const Color _textColor = Colors.white;
  static const Color _backgroundColor = Colors.grey;

  static bool _isToastShowing = false;

  static void showToastDialog(BuildContext context, String message) {
    if (!_isToastShowing) {
      _isToastShowing = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              backgroundColor: _backgroundColor,
              duration: const Duration(seconds: _duration),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: _fontSize,
                    color: _textColor,
                  ),
                ),
              ),
            ),
          )
          .closed
          .then((_) {
        _isToastShowing = false;
      });
    }
  }
}