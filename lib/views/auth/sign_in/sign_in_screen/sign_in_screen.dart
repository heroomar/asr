
import '../../../../views/auth/sign_in/sign_in_screen/sign_in_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(
      mobileScaffold: SignInScreenMobile(),
    );
  }
}