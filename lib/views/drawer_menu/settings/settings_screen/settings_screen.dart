import '../../../../../utils/responsive_layout.dart';
import 'settings_screen_mobile.dart';

import '../../../../utils/basic_widget_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: SettingsScreenMobile());
  }
}