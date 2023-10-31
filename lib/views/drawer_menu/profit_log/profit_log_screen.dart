import '../../../../views/drawer_menu/profit_log/profit_log_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class ProfitLogScreen extends StatelessWidget {
  const ProfitLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: ProfitLogScreenMobile(),
    );
  }
}