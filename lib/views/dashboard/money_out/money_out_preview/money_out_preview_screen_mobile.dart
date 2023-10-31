import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/dashboard/money_out/money_out_controller.dart';
import '../../../../controller/dashboard/money_out/money_out_manual_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/others/money_out_amount_information_widget.dart';
import '../../../../widgets/others/money_out_amount_preview_widget.dart';

class MoneyOutPreviewScreenMobile extends StatelessWidget {
  MoneyOutPreviewScreenMobile({super.key});

  final controller = Get.put(MoneyOutController());
  final manualController = Get.put(MoneyOutManualController());

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.preview.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: const BouncingScrollPhysics(),
      children: [
        _moneyOutAmountWidget(context),
        _moneyOutAmountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _moneyOutAmountWidget(BuildContext context) {
    return moneyOutAmountPreviewWidget(
        amount:
            "${controller.moneyOutAmountTextController.text.tr} ${LocalStorage.getBaseCurrency()}");
  }

  _moneyOutAmountInformationWidget(BuildContext context) {
    return moneyOutAmountInformationWidget(
      exchangeRate: Strings.exchange,
      feeRow:
          "${1.0} ${LocalStorage.getBaseCurrency()} - ${controller.rate} ${LocalStorage.getBaseCurrency()}",
      information: Strings.amountInformation.tr,
      enteredAmount: Strings.enteredAmount.tr,
      enterAmountRow:
          "${controller.amount.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()}",
      charges: Strings.charges.tr,
      received: Strings.youWillGet.tr,
      receivedRow:
          "${controller.payable.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()}",
      total: Strings.totalPayable.tr,

      // fees and payable
      chargeRate:
          "${controller.totalCharge.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()}",
      totalRow: "${controller.willGet.value} ${LocalStorage.getBaseCurrency()}",
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: Dimensions.marginSizeVertical * 1.5,
        ),
        child: Obx(
          () => manualController.isUpdateLoading
              ? const CustomLoadingAPI()
              : PrimaryButton(
                  title: Strings.confirm.tr,
                  onPressed: () {
                    manualController.moneyOutSubmitProcess();
                  },
                  borderColor: CustomColor.primaryLightColor,
                  buttonColor: CustomColor.primaryLightColor,
                ),
        ));
  }
}
