import '../../../../views/dashboard/money_transfer/money_transfer_screen/money_transfer_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class MoneyTransferScreen extends StatelessWidget {
  const MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: MoneyTransferScreenMobile(),
    );
  }
}