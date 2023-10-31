import '../../../../views/drawer_menu/settings/change_password/change_password_screen_mobile.dart';

import '../../../../utils/basic_widget_imports.dart';
import '../../../../utils/responsive_layout.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(mobileScaffold: ChangePasswordScreenMobile(),);
  }
}