
class InvestPlaneModel {
  Message message;
  Data data;
  String type;

  InvestPlaneModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory InvestPlaneModel.fromJson(Map<String, dynamic> json) =>
      InvestPlaneModel(
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
  Instructions instructions;
  List<Plan> plans;

  Data({
    required this.instructions,
    required this.plans,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instructions: Instructions.fromJson(json["instructions"]),
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions.toJson(),
        "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
      };
}

class Instructions {
  List<String> profitReturnType;
  String status;

  Instructions({
    required this.profitReturnType,
    required this.status,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        profitReturnType:
            List<String>.from(json["profit_return_type"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "profit_return_type":
            List<dynamic>.from(profitReturnType.map((x) => x)),
        "status": status,
      };
}

class Plan {
  int id;
  String slug;
  String name;
  String duration;
  String profitReturnType;
  String minInvest;
  String minInvestOffer;
  String maxInvest;
  String profitFixed;
  String profitPercent;
  bool status;
  DateTime createdAt;

  Plan({
    required this.id,
    required this.slug,
    required this.name,
    required this.duration,
    required this.profitReturnType,
    required this.minInvest,
    required this.minInvestOffer,
    required this.maxInvest,
    required this.profitFixed,
    required this.profitPercent,
    required this.status,
    required this.createdAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        duration: json["duration"],
        profitReturnType: json["profit_return_type"],
        minInvest: json["min_invest"],
        minInvestOffer: json["min_invest_offer"],
        maxInvest: json["max_invest"],
        profitFixed: json["profit_fixed"],
        profitPercent: json["profit_percent"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "duration": duration,
        "profit_return_type": profitReturnType,
        "min_invest": minInvest,
        "min_invest_offer": minInvestOffer,
        "max_invest": maxInvest,
        "profit_fixed": profitFixed,
        "profit_percent": profitPercent,
        "status": status,
        "created_at": createdAt.toIso8601String(),
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
