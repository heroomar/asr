class BasicSettingModel {
  Message message;
  Data data;
  String type;

  BasicSettingModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BasicSettingModel.fromJson(Map<String, dynamic> json) =>
      BasicSettingModel(
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
  BasicSettings basicSettings;
  BaseCur baseCur;
  WebLinks webLinks;
  List<Language> languages;
  SplashScreen splashScreen;
  List<OnboardScreen> onboardScreens;
  ImagePaths imagePaths;
  AppImagePaths appImagePaths;

  Data({
    required this.basicSettings,
    required this.baseCur,
    required this.webLinks,
    required this.languages,
    required this.splashScreen,
    required this.onboardScreens,
    required this.imagePaths,
    required this.appImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basicSettings: BasicSettings.fromJson(json["basic_settings"]),
        baseCur: BaseCur.fromJson(json["base_cur"]),
        webLinks: WebLinks.fromJson(json["web_links"]),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        splashScreen: SplashScreen.fromJson(json["splash_screen"]),
        onboardScreens: List<OnboardScreen>.from(
            json["onboard_screens"].map((x) => OnboardScreen.fromJson(x))),
        imagePaths: ImagePaths.fromJson(json["image_paths"]),
        appImagePaths: AppImagePaths.fromJson(json["app_image_paths"]),
      );

  Map<String, dynamic> toJson() => {
        "basic_settings": basicSettings.toJson(),
        "base_cur": baseCur.toJson(),
        "web_links": webLinks.toJson(),
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
        "splash_screen": splashScreen.toJson(),
        "onboard_screens":
            List<dynamic>.from(onboardScreens.map((x) => x.toJson())),
        "image_paths": imagePaths.toJson(),
        "app_image_paths": appImagePaths.toJson(),
      };
}

class AppImagePaths {
  String baseUrl;
  String pathLocation;
  String defaultImage;

  AppImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory AppImagePaths.fromJson(Map<String, dynamic> json) => AppImagePaths(
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

class BaseCur {
  int id;
  String code;
  String symbol;
  String rate;
  bool both;
  bool senderCurrency;
  bool receiverCurrency;

  BaseCur({
    required this.id,
    required this.code,
    required this.symbol,
    required this.rate,
    required this.both,
    required this.senderCurrency,
    required this.receiverCurrency,
  });

  factory BaseCur.fromJson(Map<String, dynamic> json) => BaseCur(
        id: json["id"],
        code: json["code"],
        symbol: json["symbol"],
        rate: json["rate"],
        both: json["both"],
        senderCurrency: json["senderCurrency"],
        receiverCurrency: json["receiverCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "both": both,
        "senderCurrency": senderCurrency,
        "receiverCurrency": receiverCurrency,
      };
}

class BasicSettings {
  int id;
  String siteName;
  String siteTitle;
  String timezone;
  String siteLogo;
  String siteLogoDark;
  String siteFav;
  String siteFavDark;
  bool userKycStatus;

  BasicSettings({
    required this.id,
    required this.siteName,
    required this.siteTitle,
    required this.timezone,
    required this.siteLogo,
    required this.siteLogoDark,
    required this.siteFav,
    required this.siteFavDark,
    required this.userKycStatus,
  });

  factory BasicSettings.fromJson(Map<String, dynamic> json) => BasicSettings(
        id: json["id"],
        siteName: json["site_name"],
        siteTitle: json["site_title"],
        timezone: json["timezone"],
        siteLogo: json["site_logo"],
        siteLogoDark: json["site_logo_dark"],
        siteFav: json["site_fav"],
        siteFavDark: json["site_fav_dark"],
        userKycStatus: json["user_kyc_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "site_title": siteTitle,
        "timezone": timezone,
        "site_logo": siteLogo,
        "site_logo_dark": siteLogoDark,
        "site_fav": siteFav,
        "site_fav_dark": siteFavDark,
        "user_kyc_status": userKycStatus,
      };
}

class ImagePaths {
  String basePath;
  String pathLocation;
  String defaultImage;

  ImagePaths({
    required this.basePath,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
        basePath: json["base_path"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "base_path": basePath,
        "path_location": pathLocation,
        "default_image": defaultImage,
      };
}

class Language {
  int id;
  String name;
  String code;
  bool status;

  Language({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "status": status,
      };
}

class OnboardScreen {
  String title;
  String subTitle;
  String image;
  bool status;

  OnboardScreen({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sub_title": subTitle,
        "image": image,
        "status": status,
      };
}

class SplashScreen {
  String image;
  String version;

  SplashScreen({
    required this.image,
    required this.version,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
        image: json["image"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "version": version,
      };
}

class WebLinks {
  String privacyPolicy;
  String aboutUs;
  String contactUs;

  WebLinks({
    required this.privacyPolicy,
    required this.aboutUs,
    required this.contactUs,
  });

  factory WebLinks.fromJson(Map<String, dynamic> json) => WebLinks(
        privacyPolicy: json["privacy-policy"],
        aboutUs: json["about-us"],
        contactUs: json["contact-us"],
      );

  Map<String, dynamic> toJson() => {
        "privacy-policy": privacyPolicy,
        "about-us": aboutUs,
        "contact-us": contactUs,
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
