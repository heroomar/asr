import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/dashboard/money_out/money_out_screen/money_out_screen_mobile.dart';

class MoneyOutScreen extends StatelessWidget {
  const MoneyOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: MoneyOutScreenMobile(),
    );
  }
}