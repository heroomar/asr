import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/dashboard/add_money/add_money_preview_screen/add_money_preview_screen_mobile.dart';

class AddMoneyPreviewScreen extends StatelessWidget {
  const AddMoneyPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: AddMoneyPreviewScreenMobile(),
    );
  }
}