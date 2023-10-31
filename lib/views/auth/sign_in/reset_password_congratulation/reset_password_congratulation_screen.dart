import 'reset_password_congratulation_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';


class ResetPasswordCongratulationScreen extends StatelessWidget {
  const ResetPasswordCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   const ResponsiveLayout(
      mobileScaffold:
      ResetPasswordCongratulationScreenMobile(),
    );
  }
}