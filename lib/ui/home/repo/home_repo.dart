import 'package:flutterbase/session/model/session.dart';
import 'package:flutterbase/session/repo/session_repo.dart';
import 'package:flutterbase/ui/home/ds/home_api_ds.dart';
import 'package:flutterbase/ui/home/entity/product_list.dart';

class HomeRepo {
  final _sessionRepo = SessionRepo();
  final _homeApiDS = HomeApiDS();

  Stream<Session> getSession() {
    return _sessionRepo.getSession();
  }

  Stream<List<Post>> getAllPost() {
    return _homeApiDS.getAllPost();
  }
}
