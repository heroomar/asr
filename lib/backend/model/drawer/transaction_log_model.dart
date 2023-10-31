
class TransactionModel {
  Message message;
  Data data;
  String type;

  TransactionModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
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
  List<String> transactionTypes;
  List<Transaction> transactions;

  Data({
    required this.instructions,
    required this.transactionTypes,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instructions: Instructions.fromJson(json["instructions"]),
        transactionTypes:
            List<String>.from(json["transaction_types"].map((x) => x)),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions.toJson(),
        "transaction_types": List<dynamic>.from(transactionTypes.map((x) => x)),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Instructions {
  String slug;

  Instructions({
    required this.slug,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
      };
}

class Transaction {
  String type;
  String trxId;
  String requestCurrency;
  String receiveAmount;
  int status;
  DateTime createdAt;

  Transaction({
    required this.type,
    required this.trxId,
    required this.requestCurrency,
    required this.receiveAmount,
    required this.status,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        type: json["type"],
        trxId: json["trx_id"],
        requestCurrency: json["request_currency"],
        receiveAmount: json["receive_amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "trx_id": trxId,
        "request_currency": requestCurrency,
        "receive_amount": receiveAmount,
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
