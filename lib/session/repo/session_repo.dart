import 'package:flutterbase/session/model/session.dart';

import '../session_manager.dart';

class SessionRepo {
  final _sessionManager = SessionManager();

  Stream<Session> addSession(Session session) =>
      _sessionManager.addSession(session);

  //Stream<bool> updateUser(User user) => _sessionManager.updateUser(user);

  Stream<Session> getSession() => _sessionManager.getSession();

  Stream<bool> isSessionActive() => _sessionManager.isSessionActive();

  Stream<bool> clearSession() => _sessionManager.clearSession();

  Stream<bool> sessionExpireObservable() =>
      _sessionManager.sessionExpireObservable();

/*Stream<bool> updateFcmToken(String fcmToken) =>
      _sessionManager.updateFcmToken(fcmToken);

  Stream<String> getFcmToken() => _sessionManager.getFcmToken();*/
}
