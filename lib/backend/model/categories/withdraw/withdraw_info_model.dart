
class WithdrawInfoModel {
  Message message;
  Data data;
  String type;

  WithdrawInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory WithdrawInfoModel.fromJson(Map<String, dynamic> json) =>
      WithdrawInfoModel(
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
  BalanceType balanceType;
  List<UserWallet> userWallets;
  List<PaymentGateway> paymentGateways;

  Data({
    required this.balanceType,
    required this.userWallets,
    required this.paymentGateways,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        balanceType: BalanceType.fromJson(json["balance_type"]),
        userWallets: List<UserWallet>.from(
            json["user_wallets"].map((x) => UserWallet.fromJson(x))),
        paymentGateways: List<PaymentGateway>.from(
            json["payment_gateways"].map((x) => PaymentGateway.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "balance_type": balanceType.toJson(),
        "user_wallets": List<dynamic>.from(userWallets.map((x) => x.toJson())),
        "payment_gateways":
            List<dynamic>.from(paymentGateways.map((x) => x.toJson())),
      };
}

class BalanceType {
  bool status;
  String message;
  List<Type> types;

  BalanceType({
    required this.status,
    required this.message,
    required this.types,
  });

  factory BalanceType.fromJson(Map<String, dynamic> json) => BalanceType(
        status: json["status"],
        message: json["message"],
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}

class Type {
  String name;
  String value;

  Type({
    required this.name,
    required this.value,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class PaymentGateway {
  int id;
  String type;
  String name;
  String alias;
  bool status;
  List<CurrencyElement> currencies;

  PaymentGateway({
    required this.id,
    required this.type,
    required this.name,
    required this.alias,
    required this.status,
    required this.currencies,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        alias: json["alias"],
        status: json["status"],
        currencies: List<CurrencyElement>.from(
            json["currencies"].map((x) => CurrencyElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "alias": alias,
        "status": status,
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
      };
}

class CurrencyElement {
  int id;
  int paymentGatewayId;
  String name;
  String alias;
  String currencyCode;
  String currencySymbol;
  dynamic image;
  String minLimit;
  String maxLimit;
  String percentCharge;
  String fixedCharge;
  String rate;
  DateTime createdAt;
  DateTime updatedAt;

  CurrencyElement({
    required this.id,
    required this.paymentGatewayId,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrencyElement.fromJson(Map<String, dynamic> json) =>
      CurrencyElement(
        id: json["id"],
        paymentGatewayId: json["payment_gateway_id"],
        name: json["name"],
        alias: json["alias"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        image: json["image"],
        minLimit: json["min_limit"],
        maxLimit: json["max_limit"],
        percentCharge: json["percent_charge"],
        fixedCharge: json["fixed_charge"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_gateway_id": paymentGatewayId,
        "name": name,
        "alias": alias,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "image": image,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "percent_charge": percentCharge,
        "fixed_charge": fixedCharge,
        "rate": rate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserWallet {
  String balance;
  String profitBalance;
  bool status;
  UserWalletCurrency currency;

  UserWallet({
    required this.balance,
    required this.profitBalance,
    required this.status,
    required this.currency,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        balance: json["balance"],
        profitBalance: json["profit_balance"],
        status: json["status"],
        currency: UserWalletCurrency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "profit_balance": profitBalance,
        "status": status,
        "currency": currency.toJson(),
      };
}

class UserWalletCurrency {
  int id;
  String code;
  String rate;
  bool both;
  bool senderCurrency;
  bool receiverCurrency;
  String editData;

  UserWalletCurrency({
    required this.id,
    required this.code,
    required this.rate,
    required this.both,
    required this.senderCurrency,
    required this.receiverCurrency,
    required this.editData,
  });

  factory UserWalletCurrency.fromJson(Map<String, dynamic> json) =>
      UserWalletCurrency(
        id: json["id"],
        code: json["code"],
        rate: json["rate"],
        both: json["both"],
        senderCurrency: json["senderCurrency"],
        receiverCurrency: json["receiverCurrency"],
        editData: json["editData"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "rate": rate,
        "both": both,
        "senderCurrency": senderCurrency,
        "receiverCurrency": receiverCurrency,
        "editData": editData,
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
