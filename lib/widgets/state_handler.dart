import 'package:flutter/material.dart';
import 'package:flutterbase/network/view_state.dart';

import 'my_place_holder.dart';
import 'progress_view.dart';

class StateHandler extends StatelessWidget {
  final ViewState viewState;
  final Widget body;
  final Widget loadingWidget;
  final Widget errorWidget;

  StateHandler({
    @required this.viewState,
    @required this.body,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (viewState?.status) {
      case Status.COMPLETED:
        return body;
      case Status.ERROR:
        return errorWidget ?? MYPlaceHolder(message: viewState?.message);
      default:
        return loadingWidget ??
            Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ProgressView(),
              ),
            );
    }
  }
}
