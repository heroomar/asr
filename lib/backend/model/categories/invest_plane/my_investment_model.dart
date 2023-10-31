
class MyInvestmentModel {
  Message message;
  Data data;
  String type;

  MyInvestmentModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory MyInvestmentModel.fromJson(Map<String, dynamic> json) =>
      MyInvestmentModel(
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
  List<Investment> investments;

  Data({
    required this.instructions,
    required this.investments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instructions: Instructions.fromJson(json["instructions"]),
        investments: List<Investment>.from(
            json["investments"].map((x) => Investment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions.toJson(),
        "investments": List<dynamic>.from(investments.map((x) => x.toJson())),
      };
}

class Instructions {
  String status;

  Instructions({
    required this.status,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class Investment {
  int id;
  int investPlanId;
  String investAmount;
  DateTime expAt;
  String status;
  DateTime createdAt;
  InvestPlan investPlan;

  Investment({
    required this.id,
    required this.investPlanId,
    required this.investAmount,
    required this.expAt,
    required this.status,
    required this.createdAt,
    required this.investPlan,
  });

  factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        id: json["id"],
        investPlanId: json["invest_plan_id"],
        investAmount: json["invest_amount"],
        expAt: DateTime.parse(json["exp_at"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        investPlan: InvestPlan.fromJson(json["invest_plan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invest_plan_id": investPlanId,
        "invest_amount": investAmount,
        "exp_at": expAt.toIso8601String(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "invest_plan": investPlan.toJson(),
      };
}

class InvestPlan {
  int id;
  String name;
  String slug;
  String duration;
  String profitFixed;
  String profitPercent;

  InvestPlan({
    required this.id,
    required this.name,
    required this.slug,
    required this.duration,
    required this.profitFixed,
    required this.profitPercent,
  });

  factory InvestPlan.fromJson(Map<String, dynamic> json) => InvestPlan(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        duration: json["duration"],
        profitFixed: json["profit_fixed"],
        profitPercent: json["profit_percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "duration": duration,
        "profit_fixed": profitFixed,
        "profit_percent": profitPercent,
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
