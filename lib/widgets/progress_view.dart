import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  ProgressView({
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: (width != null && height != null)
            ? _getSizedProgressBar(
                width, height, color ?? Theme.of(context).primaryColor)
            : _getProgressBar(color ?? Theme.of(context).primaryColor));
  }

  Widget _getSizedProgressBar(double width, double height, Color color) {
    return SizedBox(
      width: width,
      height: height,
      child: _getProgressBar(color),
    );
  }

  Widget _getProgressBar(Color color) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
