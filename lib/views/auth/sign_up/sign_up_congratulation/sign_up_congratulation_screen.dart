import '../../../../views/auth/sign_up/sign_up_congratulation/sign_up_congratulation_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';


class SignUpCongratulationScreen extends StatelessWidget {
  const SignUpCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const ResponsiveLayout(
      mobileScaffold:
      SignUpCongratulationScreenMobile(),
    );
  }
}