import '../../../../views/drawer_menu/settings/two_f_a_security_otp_verification/two_f_a_otp_verification_screen_mobile.dart';

import '../../../../utils/basic_widget_imports.dart';
import '../../../../utils/responsive_layout.dart';

class TwoFAOtpVerificationScreen extends StatelessWidget {
  const TwoFAOtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: TwoFAOtpVerificationScreenMobile());
  }
}