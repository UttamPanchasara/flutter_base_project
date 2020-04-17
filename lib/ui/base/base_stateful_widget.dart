import 'package:flutter/material.dart';
import 'package:flutterbase/utils/app_utils.dart';
import 'package:flutterbase/widgets/progress_view.dart';

import 'base_view.dart';

abstract class BaseStatefulWidgetState<T extends StatefulWidget>
    extends State<T> implements BaseView {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onError(String errorMessageKey) {
    // do nothing
  }

  @override
  void showError(String errorMessage) {
    AppUtils.instance.showMessage(errorMessage, Colors.red, context);
  }

  @override
  void hideProgress() {
    AppUtils.instance.hideProgress(context);
  }

  @override
  void showProgress() {
    AppUtils.instance.showProgress(context);
  }

  void showProgressDialogue() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Wrap(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  ProgressView(),
                  Container(
                    margin: EdgeInsets.only(
                      left: 12,
                    ),
                    child: Text(
                      'Please wait...',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context,
      {double dividedBy = 1, double reducedBy = 0.0}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  double screenHeightExcludingToolbar(BuildContext context,
      {double dividedBy = 1}) {
    return screenHeight(context,
        dividedBy: dividedBy, reducedBy: kToolbarHeight);
  }

  @override
  void setState(fn) {
    // this is to avoid memory leak,
    // avoid setState() call if already disposed
    if (mounted) {
      super.setState(fn);
    }
  }
}
