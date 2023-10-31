import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/routes/routes.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/dashboard/add_money/add_money_controller.dart';
import '../../../../controller/dashboard/add_money/add_money_manual_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/others/add_money_amount_information_widget.dart';
import '../../../../widgets/others/add_money_amount_preview_widget.dart';

class AddMoneyPreviewScreenMobile extends StatelessWidget {
  AddMoneyPreviewScreenMobile({super.key});

  final controller = Get.put(AddMoneyController());

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
        _amountWidget(context),
        _amountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return addMoneyAmountPreviewWidget(
        amount:
            "${controller.amountTextController.text.tr} ${LocalStorage.getBaseCurrency()} ");
  }

  _amountInformationWidget(BuildContext context) {
    return addMoneyAmountInformationWidget(
      information: Strings.amountInformation.tr,
      enteredAmount: Strings.enteredAmount.tr,
      exchangeRate: Strings.exchangeRate,
      feeRow:
          "${1.0} ${LocalStorage.getBaseCurrency()} - ${double.parse(controller.rate.toStringAsFixed(2))} ${LocalStorage.getBaseCurrency()}",
      enterAmountRow:
          "${controller.amount.value} ${LocalStorage.getBaseCurrency()}",
      charges: Strings.charges.tr,

      received: Strings.youWillGet.tr,
      receivedRow:
          "${controller.amount.value} ${LocalStorage.getBaseCurrency()}",
      total: Strings.totalPayable.tr,

      // fees and payable
      chargeRate:
          "${double.parse(controller.totalCharge.value.toStringAsFixed(2))} ${LocalStorage.getBaseCurrency()}",
      totalRow:
          "${double.parse(controller.payable.value.toStringAsFixed(2))} ${LocalStorage.getBaseCurrency()}",
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 1.5,
      ),
      //  || manualController.isUpdateLoading
      child: controller.selectedCurrencyType.value.contains('automatic')
          ? Obx(() {
              return controller.isInsertLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.confirm.tr,
                      onPressed: () {
                        if (controller.selectedCurrencyType.value
                            .contains('paypal')) {
                          controller.addMoneyPaypalInsertProcess();
                        } else if (controller.selectedCurrencyType.value
                            .contains('coingate')) {
                          controller.coinGateProcess();
                        }
                      },
                    );
            })
          : Obx(() {
              final manualController = Get.put(AddMoneyManualController());
              return manualController.isUpdateLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.confirm.tr,
                      onPressed: () =>
                          manualController.addMoneyManualSubmitProcess(),
                    );
            }),
    );
  }
}
