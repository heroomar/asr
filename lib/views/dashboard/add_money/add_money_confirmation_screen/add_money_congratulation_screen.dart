import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/dashboard/add_money/add_money_confirmation_screen/add_money_congratulation_screen_mobile.dart';

class AddMoneyCongratulationScreen extends StatelessWidget {
  const AddMoneyCongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: AddMoneyCongratulationScreenMobile(),
    );
  }
}