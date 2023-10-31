
class ProfileModel {
  Message message;
  Data data;
  String type;

  ProfileModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  UserInfo userInfo;
  ImagePaths imagePaths;
  List<Country> countries;

  Data({
    required this.instructions,
    required this.userInfo,
    required this.imagePaths,
    required this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instructions: Instructions.fromJson(json["instructions"]),
        userInfo: UserInfo.fromJson(json["user_info"]),
        imagePaths: ImagePaths.fromJson(json["image_paths"]),
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructions": instructions.toJson(),
        "user_info": userInfo.toJson(),
        "image_paths": imagePaths.toJson(),
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  int id;
  String name;
  String mobileCode;
  String currencyName;
  String currencyCode;
  String currencySymbol;

  Country({
    required this.id,
    required this.name,
    required this.mobileCode,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        mobileCode: json["mobile_code"],
        currencyName: json["currency_name"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_code": mobileCode,
        "currency_name": currencyName,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
      };
}

class ImagePaths {
  String baseUrl;
  String pathLocation;
  String defaultImage;

  ImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "path_location": pathLocation,
        "default_image": defaultImage,
      };
}

class Instructions {
  String kycVerified;

  Instructions({
    required this.kycVerified,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        kycVerified: json["kyc_verified"],
      );

  Map<String, dynamic> toJson() => {
        "kyc_verified": kycVerified,
      };
}

class UserInfo {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  dynamic mobileCode;
  dynamic mobile;
  dynamic image;
  int kycVerified;
  String country;
  String city;
  String state;
  String postalCode;
  String address;
  // Kyc kyc;

  UserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    this.mobileCode,
    this.mobile,
    this.image,
    required this.kycVerified,
    required this.country,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.address,
    // required this.kyc,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        mobileCode: json["mobile_code"],
        mobile: json["mobile"],
        image: json["image"],
        kycVerified: json["kyc_verified"],
        country: json["country"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        address: json["address"],
        // kyc: Kyc.fromJson(json["kyc"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "image": image,
        "kyc_verified": kycVerified,
        "country": country,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "address": address,
        // "kyc": kyc.toJson(),
      };
}

// class Kyc {
//   List<dynamic> data;
//   String rejectReason;

//   Kyc({
//     required this.data,
//     required this.rejectReason,
//   });

//   factory Kyc.fromJson(Map<String, dynamic> json) => Kyc(
//         data: List<dynamic>.from(json["data"].map((x) => x)),
//         rejectReason: json["reject_reason"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x)),
//         "reject_reason": rejectReason,
//       };
// }

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
