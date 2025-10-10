class ApiResponse<T> {
  int? code;
  T? data;
  int? status;
  String message;

  ApiResponse.success({this.data, this.code, this.status, this.message = ""});

  ApiResponse.error(this.message, {this.data, this.code});

  bool get isSuccess => code != null && (code == 200 || code == 201);

  bool get isStatusSuccess => status == 200;
}
