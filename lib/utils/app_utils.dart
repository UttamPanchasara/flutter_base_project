import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static final AppUtils instance = AppUtils._privateConstructor();

  bool _isProgressDialogShowing = false;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  void showMessage(String message, Color color, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    if (context != null) {
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void showMessageWithState(
      String message, Color color, ScaffoldState scaffoldState) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(snackBar);
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value);
  }

  void showProgress(BuildContext context) {
    if (!_isProgressDialogShowing) {
      _isProgressDialogShowing = !_isProgressDialogShowing;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new CircularProgressIndicator(),
                ],
              ),
            ],
          );
        },
      );
    }
  }

  void hideProgress(BuildContext context) {
    if (_isProgressDialogShowing) {
      _isProgressDialogShowing = !_isProgressDialogShowing;
      Navigator.of(context).pop();
    }
  }
}
