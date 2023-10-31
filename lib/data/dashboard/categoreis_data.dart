import 'package:crypinvest/custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/dashboard/categories_widget.dart';

List<CategoriesWidget> categoriesData = [
  CategoriesWidget(
    icon: Assets.icon.investPlane,
    title: Strings.investPlan.tr,
    onTap: () {
      Get.toNamed(
        Routes.investPlanScreen,
      );
    },
  ),
  CategoriesWidget(
    icon: Assets.icon.walletadd,
    title: Strings.addMoney,
    onTap: () {
      Get.toNamed(
        Routes.addMoneyScreen,
      );
    },
  ),
  CategoriesWidget(
    icon: Assets.icon.walletadd,
    title: Strings.moneyOut.tr,
    onTap: () {
      Get.toNamed(
        // Routes.moneyOutPreviewScreen,
        Routes.moneyOutScreen,
        //  Routes.moneyOutManualPaymentScreen,
      );
    },
  ),
  CategoriesWidget(
    icon: Assets.icon.send2,
    title: Strings.moneyTransfer.tr,
    onTap: () {
      Get.toNamed(
        Routes.moneyTransferScreen,
      );
    },
  ),
];
