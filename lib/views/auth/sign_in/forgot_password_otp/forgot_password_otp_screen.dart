import '../../../../views/auth/sign_in/forgot_password_otp/forgot_password_otp_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';


class ForgotPasswordOtpVerificationScreen extends StatelessWidget {
  const ForgotPasswordOtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(
      mobileScaffold:
      ForgotPasswordOtpVerificationScreenMobile(),
    );
  }
}