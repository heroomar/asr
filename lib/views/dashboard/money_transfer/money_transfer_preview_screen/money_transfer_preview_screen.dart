
import '../../../../views/dashboard/money_transfer/money_transfer_preview_screen/money_transfer_preview_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class MoneyTransferPreviewScreen extends StatelessWidget {
  const MoneyTransferPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: MoneyTransferPreviewScreenMobile(),
    );
  }
}