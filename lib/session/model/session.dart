class Session {
  String token;

  Session({
    this.token,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {'token': token};

  @override
  String toString() {
    return toJson().toString();
  }
}
