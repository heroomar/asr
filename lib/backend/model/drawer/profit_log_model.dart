
class ProfitLogModel {
  Message message;
  Data data;
  String type;

  ProfitLogModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory ProfitLogModel.fromJson(Map<String, dynamic> json) => ProfitLogModel(
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
  List<ProfitLog> profitLogs;

  Data({
    required this.instructions,
    required this.profitLogs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instructions: Instructions.fromJson(json["instructions"]),
        profitLogs: List<ProfitLog>.from(
            json["profit_logs"].map((x) => ProfitLog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions.toJson(),
        "profit_logs": List<dynamic>.from(profitLogs.map((x) => x.toJson())),
      };
}

class Instructions {
  InstructionsInvest invest;

  Instructions({
    required this.invest,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        invest: InstructionsInvest.fromJson(json["invest"]),
      );

  Map<String, dynamic> toJson() => {
        "invest": invest.toJson(),
      };
}

class InstructionsInvest {
  String status;

  InstructionsInvest({
    required this.status,
  });

  factory InstructionsInvest.fromJson(Map<String, dynamic> json) =>
      InstructionsInvest(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class ProfitLog {
  int id;
  int userId;
  int investId;
  String profitAmount;
  DateTime createdAt;
  ProfitLogInvest invest;

  ProfitLog({
    required this.id,
    required this.userId,
    required this.investId,
    required this.profitAmount,
    required this.createdAt,
    required this.invest,
  });

  factory ProfitLog.fromJson(Map<String, dynamic> json) => ProfitLog(
        id: json["id"],
        userId: json["user_id"],
        investId: json["invest_id"],
        profitAmount: json["profit_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        invest: ProfitLogInvest.fromJson(json["invest"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "invest_id": investId,
        "profit_amount": profitAmount,
        "created_at": createdAt.toIso8601String(),
        "invest": invest.toJson(),
      };
}

class ProfitLogInvest {
  int id;
  String investAmount;
  int investPlanId;
  String status;
  InvestPlan investPlan;

  ProfitLogInvest({
    required this.id,
    required this.investAmount,
    required this.investPlanId,
    required this.status,
    required this.investPlan,
  });

  factory ProfitLogInvest.fromJson(Map<String, dynamic> json) =>
      ProfitLogInvest(
        id: json["id"],
        investAmount: json["invest_amount"],
        investPlanId: json["invest_plan_id"],
        status: json["status"],
        investPlan: InvestPlan.fromJson(json["invest_plan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invest_amount": investAmount,
        "invest_plan_id": investPlanId,
        "status": status,
        "invest_plan": investPlan.toJson(),
      };
}

class InvestPlan {
  int id;
  String name;

  InvestPlan({
    required this.id,
    required this.name,
  });

  factory InvestPlan.fromJson(Map<String, dynamic> json) => InvestPlan(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
