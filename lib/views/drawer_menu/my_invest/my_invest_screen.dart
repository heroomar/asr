
import '../../../../views/drawer_menu/my_invest/my_invest_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class MyInvestScreen extends StatelessWidget {
  const MyInvestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: MyInvestScreenMobile(),
    );
  }
}