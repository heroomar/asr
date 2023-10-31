import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/dashboard/money_out/money_out_confirmation_screen/money_out_congratulation_screen_mobile.dart';

class MoneyOutCongratulationScreen extends StatelessWidget {
  const MoneyOutCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: MoneyOutCongratulationScreenMobile(),
    );
  }
}