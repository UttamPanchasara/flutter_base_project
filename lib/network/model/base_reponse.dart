class BaseResponse<T> {
  String message;
  int status;
  T data;

  BaseResponse({
    this.message,
    this.status,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    message: json['message'],
    status: json['status'],
    data: json['data'],
  );
}