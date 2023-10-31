import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/drawer_menu/settings/two_f_a_verification_congratulation/two_f_a_verification_congratulation_screen_mobile.dart';

class TwoFAVerificationCongratulationScreen extends StatelessWidget {
  const TwoFAVerificationCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: TwoFAVerificationCongratulationScreenMobile(),
    );
  }
}