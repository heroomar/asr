import '../../../../utils/responsive_layout.dart';
import '../../../../views/drawer_menu/settings/kyc_verification/kyc_verification_screen_mobile.dart';

import '../../../../utils/basic_widget_imports.dart';

class KYCVerificationScreen extends StatelessWidget {
  const KYCVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(mobileScaffold: KYCVerificationScreenMobile());
  }
}