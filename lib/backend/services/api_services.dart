import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:crypinvest/backend/model/categories/add_money/coingate_model.dart';
import 'package:crypinvest/backend/model/categories/invest_plane/my_investment_model.dart';
import 'package:crypinvest/utils/basic_screen_imports.dart';

import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../model/auth/forgot_password_common_model.dart';
import '../model/auth/signup_model.dart';
import '../model/authorization/kyc/kyc_model.dart';
import '../model/authorization/two_fa/two_fa_model.dart';
import '../model/categories/add_money/add_money_information_model.dart';
import '../model/categories/add_money/add_money_manual_get_model.dart';
import '../model/categories/add_money/paypal_insert_model.dart';
import '../model/categories/invest_plane/invest_plane_model.dart';
import '../model/categories/money_transfer/money_transfer_wallet_model.dart';
import '../model/categories/withdraw/dynamic_input_withdraw_model.dart';
import '../model/categories/withdraw/withdraw_info_model.dart';
import '../model/common/common_success_model.dart';
import '../model/dashbaord/dashboard_model.dart';
import '../model/drawer/profit_log_model.dart';
import '../model/drawer/transaction_log_model.dart';
import '../model/profile/profile_model.dart';
import '../model/auth/basic_setting_model.dart';
import '../model/auth/signin_model.dart';
import 'api_endpoint.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

final log = logger(ApiServices);

class ApiServices {
  static var client = http.Client();

  //! basic setting model

  static Future<BasicSettingModel?> basicSettingApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.basicURL,
        code: 200,
        duration: 25,
        showResult: true,
      );
      if (mapResponse != null) {
        BasicSettingModel basicSettingModel =
            BasicSettingModel.fromJson(mapResponse);
        // CustomSnackBar.success(profileModel.message.success.first.toString());
        return basicSettingModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from  basic api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!  basic api');
      return null;
    }
    return null;
  }

//Login Api method
  static Future<SignInModel?> signInApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.loginURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        SignInModel loginModel = SignInModel.fromJson(mapResponse);
        // CustomSnackBar.success(loginModel.message.success.first.toString());
        return loginModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in LoginModel');
      return null;
    }
    return null;
  }

//SignUp Api method
  static Future<SignUpModel?> signUpApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.signUpURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        SignUpModel signUpModel = SignUpModel.fromJson(mapResponse);
        CustomSnackBar.success(signUpModel.message.success.first.toString());
        return signUpModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from sign up api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in LoginModel');
      return null;
    }
    return null;
  }

  //email verification Api method
  static Future<CommonSuccessModel?> emailVerificationApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.emailVerificationURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        // if(kDebugMode){
        //   CustomSnackBar.success(
        //       commonSuccessModel.message.success.first.toString());
        // }
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from email verification api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //sign up resend otp Api method
  static Future<CommonSuccessModel?> signUpResendOtpApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.signUpResendOtpURL,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            commonSuccessModel.message!.success!.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from sign Up resend otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //Forgot Password Otp Api method
  static Future<ForgotPasswordCommonModel?> forgotPasswordEmailApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.forgotPasswordOtpURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        ForgotPasswordCommonModel forgotPasswordCommonModel =
            ForgotPasswordCommonModel.fromJson(mapResponse);
        CustomSnackBar.success(
            forgotPasswordCommonModel.message!.success!.first.toString());
        return forgotPasswordCommonModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from forgot password email api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //Forgot Password resend Otp Api method
  static Future<ForgotPasswordCommonModel?> forgotPasswordResendOtpApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.forgotPasswordResendOtpURL,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        ForgotPasswordCommonModel forgotPasswordCommonModel =
            ForgotPasswordCommonModel.fromJson(mapResponse);
        CustomSnackBar.success(
            forgotPasswordCommonModel.message!.success!.first.toString());
        return forgotPasswordCommonModel;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from forgot password resend otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //Forgot Password Otp Api method
  static Future<ForgotPasswordCommonModel?> forgotPasswordVerifyOtpApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.forgotPasswordVerifyOtpURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        ForgotPasswordCommonModel forgotPasswordCommonModel =
            ForgotPasswordCommonModel.fromJson(mapResponse);
        CustomSnackBar.success(
            forgotPasswordCommonModel.message!.success!.first.toString());
        return forgotPasswordCommonModel;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from forgot password verify otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //reset password Api method
  static Future<CommonSuccessModel?> resetPasswordApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        ApiEndpoint.resetPasswordURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //     commonSuccessModel.message.success.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from reset password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
  //dashboard

  static Future<DashboardModel?> dashboardAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.dashboardURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        DashboardModel dashboardModel = DashboardModel.fromJson(mapResponse);

        return dashboardModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from dashboard Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in money dashboard Model Api');
      return null;
    }
    return null;
  }

  //! profile get
  static Future<ProfileModel?> profileApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.profileURL,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        ProfileModel profileModel = ProfileModel.fromJson(mapResponse);
        // CustomSnackBar.success(profileModel.message.success.first.toString());
        return profileModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from profile api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

// !  profile update Api method no image
  static Future<CommonSuccessModel?> updateProfileWithoutImageApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.profileUpdateURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel updateProfileModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            updateProfileModel.message!.success!.first.toString());
        return updateProfileModel;
      }
    } catch (e) {
      log.e('err from profile update api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //! profile update api
  static Future<CommonSuccessModel?> updateProfileWithImageApi(
      {required Map<String, String> body, required String filepath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart(
        ApiEndpoint.profileUpdateURL,
        body,
        filepath,
        'image',
        code: 200,
      );

      if (mapResponse != null) {
        CommonSuccessModel profileUpdateModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            profileUpdateModel.message!.success!.first.toString());
        return profileUpdateModel;
      }
    } catch (e) {
      log.e('err from profile update api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //!change password Api method
  static Future<CommonSuccessModel?> changePasswordApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.changePasswordURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            commonSuccessModel.message!.success!.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from change password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //! lout out api
  static Future<CommonSuccessModel?> logOutApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.logOutURL,
        body,
        code: 200,
      );
      if (mapResponse != null) {
        CommonSuccessModel logoutModel =
            CommonSuccessModel.fromJson(mapResponse);

        return logoutModel;
      }
    } catch (e) {
      log.e('err from log Out api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //!add money

  static Future<AddMoneyPaymentGatewayModel?>
      addMoneyPaymentGatewayAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.addMoneyInfoURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        AddMoneyPaymentGatewayModel addMoneyPaymentGatewayModel =
            AddMoneyPaymentGatewayModel.fromJson(mapResponse);

        return addMoneyPaymentGatewayModel;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Add Money Payment Gateway api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in add money info Api');
      return null;
    }
    return null;
  }

  //! add money paypal insert
  static Future<AddMoneyPaypalInsertModel?> paypalInsertApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.addMoneySubmitURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        AddMoneyPaypalInsertModel addMoneyPaypalInsertModel =
            AddMoneyPaypalInsertModel.fromJson(mapResponse);
        CustomSnackBar.success(
            addMoneyPaypalInsertModel.message.success.first.toString());
        return addMoneyPaypalInsertModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from change password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //!coin gate process
  static Future<CoinGateModel?> coinGateInsertApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.addMoneySubmitURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CoinGateModel coinGateModel = CoinGateModel.fromJson(mapResponse);
        CustomSnackBar.success(coinGateModel.message.success.first.toString());
        return coinGateModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from change password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
//add money get manual

  static Future<AddMoneyManualGetModel?> addMoneyManualGetApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.addMoneyManualGetURL}${LocalStorage.getAlias()}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        AddMoneyManualGetModel addMoneyManualGetModel =
            AddMoneyManualGetModel.fromJson(mapResponse);
        return addMoneyManualGetModel;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Add Money Payment Gateway api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in add money info Api');
      return null;
    }
    return null;
  }

  //manual confirm
  static Future<CommonSuccessModel?> addMoneyManualConfirmApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.addMoneyConfirmURL,
        body,
        showResult: true,
        fieldList: fieldList,
        pathList: pathList,
      );
      if (mapResponse != null) {
        CommonSuccessModel registrationModel =
            CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //     registrationModel.message!.success!.first.toString());
        return registrationModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from add money confirm api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in add money confirm Model');
      return null;
    }
    return null;
  }
  //!transfer Money

  static Future<MoneyTransferWallet?> transferMoneyWalletApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.transferMoneyWalletURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        MoneyTransferWallet moneyTransferWallet =
            MoneyTransferWallet.fromJson(mapResponse);

        return moneyTransferWallet;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from money Transfer Wallet api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in money Transfer Wallet Api');
      return null;
    }
    return null;
  }

  //transfer submit
  static Future<CommonSuccessModel?> transferMoneySubmitApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.transferMoneySubmitURL,
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from transfer money api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //todo_withdraw
//withdraw info
  static Future<WithdrawInfoModel?> withdrawInfoApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.withdrawInfoURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        WithdrawInfoModel withdrawInfoModel =
            WithdrawInfoModel.fromJson(mapResponse);

        return withdrawInfoModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from withdraw info api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in withdraw info api');
      return null;
    }
    return null;
  }

//withdraw dynamic
  static Future<DynamicInputWithdrawModel?> withdrawDynamicApi(currency) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.withdrawDynamicURL}$currency",
        code: 200,
        showResult: false,
      );
      debugPrint(mapResponse.toString());
      if (mapResponse != null) {
        DynamicInputWithdrawModel dynamicInputWithdrawModel =
            DynamicInputWithdrawModel.fromJson(mapResponse);

        return dynamicInputWithdrawModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from withdraw dynamic api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! withdraw dynamic Api');
      return null;
    }
    return null;
  }

  // withdraw submit
  static Future<CommonSuccessModel?> withdrawSubmitApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).multipartMultiFile(
        ApiEndpoint.withdrawSubmitURL,
        body,
        showResult: true,
        fieldList: fieldList,
        pathList: pathList,
      );
      if (mapResponse != null) {
        CommonSuccessModel registrationModel =
            CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //     registrationModel.message.success.first.toString());

        return registrationModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from withdraw submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

// !Invest Plane
  static Future<InvestPlaneModel?> investPlaneApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.investPlaneURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        InvestPlaneModel dynamicInputWithdrawModel =
            InvestPlaneModel.fromJson(mapResponse);

        log.i(mapResponse.toString());

        return dynamicInputWithdrawModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from invest plane api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! invest plane Api');
      return null;
    }
    return null;
  }

  //my investment
  static Future<MyInvestmentModel?> myInvestmentApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.myInvestmentURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        MyInvestmentModel myInvestModel =
            MyInvestmentModel.fromJson(mapResponse);

        return myInvestModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from my Invest Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! my Invest Model Api');
      return null;
    }
    return null;
  }

  // invest
  static Future<CommonSuccessModel?> planPurchaseAPi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.investPurchaseURL}${LocalStorage.getSlug()}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //     commonSuccessModel.message!.!.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from invest purchase api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

//!transaction
  static Future<TransactionModel?> transactionApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.transactionURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        TransactionModel transactionModel =
            TransactionModel.fromJson(mapResponse);

        return transactionModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from my transaction api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! my transaction Model Api');
      return null;
    }
    return null;
  }

  //!profit log
  static Future<ProfitLogModel?> profitLogApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.profitLog,
        code: 200,
        duration: 20,
        showResult: false,
      );
      if (mapResponse != null) {
        ProfitLogModel profitLogModel = ProfitLogModel.fromJson(mapResponse);

        return profitLogModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from profit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! profit Model Api');
      return null;
    }
    return null;
  }

  //! google two fa
  static Future<GoogleTwoFaModel?> googleTwoFaApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.twoFaStatusURL,
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        GoogleTwoFaModel googleTwoFaModel =
            GoogleTwoFaModel.fromJson(mapResponse);

        return googleTwoFaModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from my google two fa api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! my google two fa Model Api');
      return null;
    }
    return null;
  }
  //google two fa submit

  static Future<CommonSuccessModel?> twoFaVerifyAPi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.twoFaSubmitURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel twoFaModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(twoFaModel.message!.success!.first.toString());
        return twoFaModel;
      }
    } catch (e) {
      log.e('err from two Fa Verify api service ==> $e');
      // CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //kyc get
  static Future<KycModel?> getKycAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.kycInputURL,
        code: 200,
      );
      if (mapResponse != null) {
        KycModel kycModel = KycModel.fromJson(mapResponse);

        return kycModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from  kyc get Api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in kyc get data Api');
      return null;
    }
    return null;
  }

  // with img update profile api
  static Future<CommonSuccessModel?> updateKYCApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.kycSubmitURL,
        body,
        showResult: true,
        fieldList: fieldList,
        pathList: pathList,
      );
      if (mapResponse != null) {
        CommonSuccessModel registrationModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            registrationModel.message!.success!.first.toString());
        return registrationModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from update kyc api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in update kyc Model');
      return null;
    }
    return null;
  }



  static Future<CommonSuccessModel?> MetaMaskSuccess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post('https://asrcoin.io/api/v1/user/add-money/metamask',
          body,
          code: 200);
      if (mapResponse != null) {
        CommonSuccessModel twoFaModel =
        CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(twoFaModel.message!.success!.first.toString());
        return twoFaModel;
      }
    } catch (e) {
      log.e('err from two Fa MetaMask api service ==> $e');
      // CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
