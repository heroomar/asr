
class AddMoneyPaypalInsertModel {
  Message message;
  Data data;
  String type;

  AddMoneyPaypalInsertModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory AddMoneyPaypalInsertModel.fromJson(Map<String, dynamic> json) =>
      AddMoneyPaypalInsertModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  String redirectUrl;
  List<RedirectLink> redirectLinks;

  Data({
    required this.redirectUrl,
    required this.redirectLinks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        redirectUrl: json["redirect_url"],
        redirectLinks: List<RedirectLink>.from(
            json["redirect_links"].map((x) => RedirectLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "redirect_url": redirectUrl,
        "redirect_links":
            List<dynamic>.from(redirectLinks.map((x) => x.toJson())),
      };
}

class RedirectLink {
  String href;
  String rel;
  String method;

  RedirectLink({
    required this.href,
    required this.rel,
    required this.method,
  });

  factory RedirectLink.fromJson(Map<String, dynamic> json) => RedirectLink(
        href: json["href"],
        rel: json["rel"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "rel": rel,
        "method": method,
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
