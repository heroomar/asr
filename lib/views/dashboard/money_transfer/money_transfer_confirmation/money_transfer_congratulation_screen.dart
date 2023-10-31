import '../../../../views/dashboard/money_transfer/money_transfer_confirmation/money_transfer_congratulation_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class MoneyTransferCongratulationScreen extends StatelessWidget {
  const MoneyTransferCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: MoneyTransferCongratulationScreenMobile(),
    );
  }
}