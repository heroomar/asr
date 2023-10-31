import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/drawer_menu/settings/two_f_a_security/two_f_a_security_screen_mobile.dart';

class TwoFASecurityScreen extends StatelessWidget {
  const TwoFASecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: TwoFASecurityScreenMobile());
  }
}