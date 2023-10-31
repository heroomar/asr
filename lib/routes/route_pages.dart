import 'package:crypinvest/backend/local_storage/local_storage.dart';

import '../../../../views/drawer_menu/settings/kyc_verification/kyc_verification_screen.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart';
import '../../../../views/auth/sign_in/sign_in_screen/sign_in_screen.dart';
import '../../../../views/on_board/onboard_screen.dart';
import '../../../../views/welcome/welcome_screen.dart';
import '../bindings/splash_screen_binding.dart';
import '../language/english.dart';
import '../views/auth/sign_in/forgot_password_otp/forgot_password_otp_screen.dart';
import '../views/auth/sign_in/reset_password/reset_password_screen.dart';
import '../views/auth/sign_in/reset_password_congratulation/reset_password_congratulation_screen.dart';
import '../views/auth/sign_up/sign_up_congratulation/sign_up_congratulation_screen.dart';
import '../views/auth/sign_up/sign_up_otp/sign_up_otp_screen.dart';
import '../views/auth/sign_up/sign_up_screen/sign_up_screen.dart';
import '../views/dashboard/add_money/add_money_manual/add_money_manual_payment_screen.dart';
import '../views/dashboard/dashboard_screen/dashboard_screen.dart';
import '../views/dashboard/add_money/add_money_confirmation_screen/add_money_congratulation_screen.dart';
import '../views/dashboard/add_money/add_money_preview_screen/add_money_preview_screen.dart';
import '../views/dashboard/add_money/add_money_screen/add_money_screen.dart';
import '../views/dashboard/invest_plan/investment/investment_screen.dart';
import '../views/dashboard/invest_plan/plan/invest_plan_screen.dart';
import '../views/dashboard/money_out/money_out_confirmation_screen/money_out_congratulation_screen.dart';
import '../views/dashboard/money_out/money_out_manual_screen.dart';
import '../views/dashboard/money_out/money_out_preview/money_out_preview_screen.dart';
import '../views/dashboard/money_out/money_out_screen/money_out_screen.dart';
import '../views/dashboard/money_transfer/money_transfer_confirmation/money_transfer_congratulation_screen.dart';
import '../views/dashboard/money_transfer/money_transfer_preview_screen/money_transfer_preview_screen.dart';
import '../views/dashboard/money_transfer/money_transfer_screen/money_transfer_screen.dart';
import '../views/dashboard/update_profile/update_profile_screen.dart';
import '../views/drawer_menu/my_invest/my_invest_screen.dart';
import '../views/drawer_menu/profit_log/profit_log_screen.dart';
import '../views/drawer_menu/settings/change_password/change_password_screen.dart';
import '../views/drawer_menu/settings/settings_screen/settings_screen.dart';
import '../views/drawer_menu/settings/two_f_a_security/two_f_a_security_screen.dart';
import '../views/drawer_menu/settings/two_f_a_security_otp_verification/two_f_a_otp_verification_screen.dart';
import '../views/drawer_menu/settings/two_f_a_verification_congratulation/two_f_a_verification_congratulation_screen.dart';
import '../views/drawer_menu/transactions_log/transactions_log_screen.dart';
import '../views/splash_screen/splash_screen.dart';
import '../widgets/add_money/webview_screen.dart';
import '../widgets/drawer/drawer_webview_screen.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onBoardScreen,
      page: () => const OnBoardScreen(),
    ),
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordOtpVerificationScreen,
      page: () => const ForgotPasswordOtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordCongratulationScreen,
      page: () => const ResetPasswordCongratulationScreen(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.signUpOtpScreen,
      page: () => const SignUpOtpScreen(),
    ),
    GetPage(
      name: Routes.signUpCongratulationScreen,
      page: () => const SignUpCongratulationScreen(),
    ),

    GetPage(
      name: Routes.myInvestScreen,
      page: () => const MyInvestScreen(),
    ),
    GetPage(
      name: Routes.transactionsLogScreen,
      page: () => const TransactionsLogScreen(),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: Routes.kYCVerificationScreen,
      page: () => const KYCVerificationScreen(),
    ),
    GetPage(
      name: Routes.twoFASecurityScreen,
      page: () => const TwoFASecurityScreen(),
    ),
    GetPage(
      name: Routes.twoFAOtpScreen,
      page: () => const TwoFAOtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.twoFaVerificationSuccessScreen,
      page: () => const TwoFAVerificationCongratulationScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.addMoneyScreen,
      page: () => const AddMoneyScreen(),
    ),
    GetPage(
      name: Routes.addMoneyPreviewScreen,
      page: () => const AddMoneyPreviewScreen(),
    ),
    GetPage(
      name: Routes.addMoneyCongratulationScreen,
      page: () => const AddMoneyCongratulationScreen(),
    ),
    GetPage(
      name: Routes.moneyOutScreen,
      page: () => const MoneyOutScreen(),
    ),
    GetPage(
      name: Routes.moneyOutPreviewScreen,
      page: () => const MoneyOutPreviewScreen(),
    ),
    GetPage(
      name: Routes.moneyOutCongratulationScreen,
      page: () => const MoneyOutCongratulationScreen(),
    ),
    GetPage(
      name: Routes.moneyTransferScreen,
      page: () => const MoneyTransferScreen(),
    ),
    GetPage(
      name: Routes.moneyTransferPreviewScreen,
      page: () => const MoneyTransferPreviewScreen(),
    ),
    GetPage(
      name: Routes.moneyTransferCongratulationScreen,
      page: () => const MoneyTransferCongratulationScreen(),
    ),
    GetPage(
      name: Routes.profitLogScreen,
      page: () => const ProfitLogScreen(),
    ),
    GetPage(
      name: Routes.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: Routes.investPlanScreen,
      page: () => const InvestPlanScreen(),
    ),
    GetPage(
      name: Routes.investmentScreen,
      page: () => const InvestmentScreen(),
    ),
    GetPage(
      name: Routes.paypalWebPaymentScreen,
      page: () => PaypalWebPaymentScreen(),
    ),
    GetPage(
      name: Routes.addMoneyManualPaymentScreen,
      page: () => AddMoneyManualPaymentScreen(),
    ),
    GetPage(
      name: Routes.moneyOutManualPaymentScreen,
      page: () => MoneyOutManualPaymentScreen(),
    ),

    //help center
    GetPage(
      name: Routes.helpCenter,
      page: () => WebPaymentScreen(
        title: Strings.helpCenter,
        url: 'https://asrcoin.io/contact',
        // url: LocalStorage.getContactUs(),
      ),
    ),

    //privacy policy
    GetPage(
      name: Routes.privacyPolicy,
      page: () => WebPaymentScreen(
        title: Strings.privacyAndPolicy,
        url: 'https://asrcoin.io/link/privacy-policy',
        // url: LocalStorage.getPrivacyPolicy(),
      ),
    ),

    //about us
    GetPage(
      name: Routes.aboutUs,
      page: () => WebPaymentScreen(
        title: Strings.aboutUs,
        url: 'https://asrcoin.io/about',
        // url: LocalStorage.getAboutUs(),
      ),
    ),
  ];
}
