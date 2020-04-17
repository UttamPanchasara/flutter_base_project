import 'package:flutterbase/network/view_state.dart';
import 'package:rxdart/rxdart.dart';

import 'app_exception.dart';

class ApiManager {
  Stream<ViewState<T>> callApi<T>(Stream source, {customResponse}) {
    return source.map((response) {
      return ViewState<T>.completed(customResponse ?? response);
    }).onErrorReturnWith((error) {
      return ViewState<T>.error(error.toString(),
          error is NoInternetException ? Type.CONNECTION : Type.OTHER);
    }).startWith(ViewState<T>.loading());
  }
}
