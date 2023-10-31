import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import 'invest_plan_mobile_layout.dart';

class InvestPlanScreen extends StatelessWidget {
  const InvestPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: InvestPlanMobileLayout(),
    );
  }
}
