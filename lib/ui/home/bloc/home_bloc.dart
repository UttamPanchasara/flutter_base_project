import 'package:flutterbase/network/view_state.dart';
import 'package:flutterbase/ui/base/base_bloc.dart';
import 'package:flutterbase/ui/home/repo/home_repo.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  HomeRepo _homeRepo = HomeRepo();
  final viewState = PublishSubject<ViewState>();

  void getAllPost() {
    subscription.add(handleAPICall(_homeRepo.getAllPost()).listen((viewState) {
      this.viewState.add(viewState);
    }));
  }

  @override
  void dispose() {
    super.dispose();
    viewState?.close();
  }
}
