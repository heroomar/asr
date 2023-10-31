/// Wallet Mobile app
/// universal link & deeplink should end with '/'
class CryptoWallet {
  static const CryptoWallet metamask = CryptoWallet(
    universalLink: 'https://metamask.app.link/',
    deeplink: 'metamask://',
    walletName: 'Metamask',
  );
  static const CryptoWallet trustWallet = CryptoWallet(
    universalLink: 'https://link.trustwallet.com/',
    deeplink: 'trust://',
    walletName: 'Trust',
  );
  static const CryptoWallet rainbowMe = CryptoWallet(
    universalLink: 'https://rainbow.me/',
    deeplink: 'rainbow://',
    walletName: 'Rainbow',
  );

  /// universal link for iOS
  final String universalLink;

  /// deeplink for android
  final String? deeplink;

  final String walletName;

  const CryptoWallet({
    required this.universalLink,
    required this.walletName,
    this.deeplink,
  });

  factory CryptoWallet.fromJson(Map<String, dynamic> json) => CryptoWallet(
        universalLink: json["universalLink"],
        deeplink: json["deeplink"],
        walletName: json["walletName"],
      );

  Map<String, dynamic> toJson() => {
        "universalLink": universalLink,
        "deeplink": deeplink,
        "walletName": walletName,
      };
}
