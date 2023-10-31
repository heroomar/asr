import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/dashboard/money_out/money_out_preview/money_out_preview_screen_mobile.dart';

class MoneyOutPreviewScreen extends StatelessWidget {
  const MoneyOutPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: MoneyOutPreviewScreenMobile(),
    );
  }
}