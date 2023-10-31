import 'package:crypinvest/extensions/custom_extensions.dart';
import '../local_storage/local_storage.dart';

class ApiEndpoint {
  static const String mainDomain = "https://asrcoin.io";
  static const String baseUrl = "$mainDomain/api/v1";

  /*basic settings*/
  static String basicURL = '/settings/basic-settings'.addBaseURl();
  static String languageURL = '/settings/language'.addBaseURl();

  /*login*/
  static String loginURL = '/login'.addBaseURl();

  /*forgot password section*/
  static String forgotPasswordOtpURL =
      '/password/forgot/find/user'.addBaseURl();
  static String forgotPasswordResendOtpURL =
      '/password/forgot/resend/code?token=${LocalStorage.getToken()}'
          .addBaseURl();
  static String forgotPasswordVerifyOtpURL =
      '/password/forgot/verify/code'.addBaseURl();
  static String resetPasswordURL = '/password/forgot/reset'.addBaseURl();

  /*signup section*/
  static String signUpURL = '/register'.addBaseURl();
  static String emailVerificationURL =
      '/authorize/mail/verify/code'.addBaseURl();
  static String signUpResendOtpURL =
      '/authorize/mail/resend/code?token=${LocalStorage.getMailToken()}'
          .addBaseURl();

  /*profile section*/
  static String profileURL = '/user/profile/info'.addBaseURl();
  static String profileUpdateURL = '/user/profile/info/update'.addBaseURl();
  static String changePasswordURL =
      '/user/profile/password/update'.addBaseURl();
  static String logOutURL = '/user/logout'.addBaseURl();

/*================================*/
  /*dashboard url*/
  static String dashboardURL = '/user/dashboard'.addBaseURl();

  /*================================*/
  //!add money
  static String addMoneyInfoURL =
      '/user/add-money/payment-gateways'.addBaseURl();
  static String addMoneyManualGetURL =
      '/user/add-money/manual/input-fields?alias='.addBaseURl();
  static String addMoneySubmitURL =
      '/user/add-money/automatic/submit'.addBaseURl();
  static String addMoneyConfirmURL =
      '/user/add-money/manual/submit'.addBaseURl();
  /*================================*/
  //!money transfer
  static String transferMoneyWalletURL =
      '/user/money-transfer/wallets'.addBaseURl();
  static String transferMoneySubmitURL =
      '/user/money-transfer/submit'.addBaseURl();

  /*================================*/
  //!withdraw
  static String withdrawInfoURL = '/user/withdraw/wallet-gateways'.addBaseURl();
  static String withdrawDynamicURL =
      '/user/withdraw/gateway/input-fields?currency='.addBaseURl();
  static String withdrawSubmitURL = '/user/withdraw/submit'.addBaseURl();

  //!invest plan
  static String investPlaneURL = '/user/invest-plan/list'.addBaseURl();
  static String investPurchaseURL = '/user/invest-plan/purchase/'.addBaseURl();
  static String myInvestmentURL =
      '/user/invest-plan/my-investments'.addBaseURl();
  //! drawer

  static String transactionURL = '/user/transaction/log'.addBaseURl();
  static String profitLog = '/user/invest-plan/profit-log'.addBaseURl();

  //! kyc
  static String kycInputURL = '/authorize/kyc/input-fields'.addBaseURl();
  static String kycSubmitURL = '/authorize/kyc/submit'.addBaseURl();

  //  ! 2fa
  static String twoFaStatusURL = '/authorize/google/2fa/status'.addBaseURl();
  static String twoFaSubmitURL = '/authorize/google/2fa/verify'.addBaseURl();

  // language
  static String languagesURL = '/settings/languages'.addBaseURl();
}
