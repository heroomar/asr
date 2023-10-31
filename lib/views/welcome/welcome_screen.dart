import '../../../../views/welcome/welcome_screen_mobile.dart';

import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(mobileScaffold: WelcomeScreenMobile());
  }
}