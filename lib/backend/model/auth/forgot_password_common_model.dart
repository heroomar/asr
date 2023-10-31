
class ForgotPasswordCommonModel {
  final Message? message;
  final Data? data;
  final String? type;

  ForgotPasswordCommonModel({
    this.message,
    this.data,
    this.type,
  });

  factory ForgotPasswordCommonModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordCommonModel(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
        "data": data?.toJson(),
        "type": type,
      };
}

class Data {
  final String? token;
  final String? waitTime;

  Data({
    this.token,
    this.waitTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        waitTime: json["wait_time"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "wait_time": waitTime,
      };
}

class Message {
  final List<String>? success;

  Message({
    this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"] == null
            ? []
            : List<String>.from(json["success"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success":
            success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
      };
}
