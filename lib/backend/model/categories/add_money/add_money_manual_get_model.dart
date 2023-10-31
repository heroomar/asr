
class AddMoneyManualGetModel {
  Message message;
  Data data;
  String type;

  AddMoneyManualGetModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory AddMoneyManualGetModel.fromJson(Map<String, dynamic> json) =>
      AddMoneyManualGetModel(
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
  List<InputField> inputFields;
  Currency currency;

  Data({
    required this.inputFields,
    required this.currency,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        inputFields: List<InputField>.from(
            json["input_fields"].map((x) => InputField.fromJson(x))),
        currency: Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "input_fields": List<dynamic>.from(inputFields.map((x) => x.toJson())),
        "currency": currency.toJson(),
      };
}

class Currency {
  String alias;

  Currency({
    required this.alias,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        alias: json["alias"],
      );

  Map<String, dynamic> toJson() => {
        "alias": alias,
      };
}

class InputField {
  String type;
  String label;
  String name;
  bool required;
  Validation validation;

  InputField({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory InputField.fromJson(Map<String, dynamic> json) => InputField(
        type: json["type"],
        label: json["label"],
        name: json["name"],
        required: json["required"],
        validation: Validation.fromJson(json["validation"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "name": name,
        "required": required,
        "validation": validation.toJson(),
      };
}

class Validation {
  String max;
  List<String> mimes;
  dynamic min;
  List<dynamic> options;
  bool required;

  Validation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
        max: json["max"],
        mimes: List<String>.from(json["mimes"].map((x) => x)),
        min: json["min"],
        options: List<dynamic>.from(json["options"].map((x) => x)),
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "max": max,
        "mimes": List<dynamic>.from(mimes.map((x) => x)),
        "min": min,
        "options": List<dynamic>.from(options.map((x) => x)),
        "required": required,
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
