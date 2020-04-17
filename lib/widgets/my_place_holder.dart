import 'package:flutter/material.dart';

class MYPlaceHolder extends StatelessWidget {
  final String message;
  final double fontSize;

  MYPlaceHolder({
    @required this.message,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          (message != null && message.isNotEmpty)
              ? message
              : 'Something went wrong',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
            fontSize: fontSize ?? 16.0,
          ),
        ),
      ),
    );
  }
}
