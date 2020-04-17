import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/session.dart';

class SessionManager {
  static final SessionManager _converter = SessionManager._internal();

  static String prefKey = "PREF_SESSION";
  static String prefFcm = "PREF_FCM";

  factory SessionManager() {
    return _converter;
  }

  SessionManager._internal();

  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  PublishSubject<bool> _sessionExpiredSubject = PublishSubject<bool>();

  Stream<bool> isSessionActive() {
    return Stream.fromFuture(getSessionPref())
        .map((session) => true)
        .onErrorReturn(false);
  }

  Stream<Session> getSession() {
    return Stream.fromFuture(getSessionPref());
  }

  Stream<Session> addSession(Session session) {
    return Stream.fromFuture(_sharedPreferences).map((sharedPreferences) {
      String jsonVal = json.encode(session.toJson());
      return sharedPreferences.setString(prefKey, jsonVal);
    }).map((noData) => session);
  }

  /// this will clear all the data from pref.
  Stream<bool> clearSession() {
    return Stream.fromFuture(_sharedPreferences).map((sharedPreferences) {
      return sharedPreferences.clear();
    }).map((noData) => true);
  }

  /*Stream<User> getUser() {
    return getSession().map((session) => session.user);
  }

  Stream<bool> updateUser(User user) {
    return getSession().flatMap((session) {
      session.user = user;
      return addSession(session).map((session) => true);
    }).onErrorReturn(false);
  }*/

  Future<Session> getSessionPref() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    try {
      String sessionJson = sharedPreferences.getString(prefKey);
      final session = Session.fromJson(json.decode(sessionJson));
      if (session?.token?.isEmpty == true /*|| session?.user == null*/)
        return Future.error("No session found");
      else
        return Future.value(session);
    } catch (exception) {
      print(exception.toString());
      return Future.error("No session found");
    }
  }

  Stream<bool> sessionExpireObservable() {
    return _sessionExpiredSubject;
  }

  void notifySessionExpired() {
    _sessionExpiredSubject.add(true);
  }
}
