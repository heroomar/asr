import '../../../../views/drawer_menu/transactions_log/transactions_log_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class TransactionsLogScreen extends StatelessWidget {
  const TransactionsLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: TransactionsLogScreenMobile(),
    );
  }
}