import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/extensions/custom_extensions.dart';
import 'package:crypinvest/routes/routes.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/dashboard/money_transfer/money_transfer_controller.dart';
import '../../../../widgets/others/money_transfer_amount_information_widget.dart';
import '../../../../widgets/others/money_transfer_amount_preview_widget.dart';
import '../../../../widgets/others/money_transfer_receiver_info_widget.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';

class MoneyTransferPreviewScreenMobile extends StatelessWidget {
  MoneyTransferPreviewScreenMobile({super.key});

  final controller = Get.put(MoneyTransferController());

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
        _moneyTransferAmountWidget(context),
        _moneyTransferReceiverInformationWidget(context),
        _moneyTransferAmountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _moneyTransferAmountWidget(BuildContext context) {
    return moneyTransferAmountPreviewWidget(
        amount:
            "${controller.sendingAmountController.text.tr} ${LocalStorage.getBaseCurrency()}");
  }

  _moneyTransferReceiverInformationWidget(BuildContext context) {
    return moneyTransferReceiverInformationWidget(
        information: Strings.receiverInformation,
        receiverEmailAddress: controller.receiverEmailAddressController.text.tr,
        emailAddress: Strings.emailAddress.tr);
  }

  _moneyTransferAmountInformationWidget(BuildContext context) {
    var total = controller.amount.value + controller.fees.value;
    return moneyTransferAmountInformationWidget(
      information: Strings.amountInformation.tr,
      enteredAmount: Strings.enteredAmount.tr,
      enterAmountRow:
          "${controller.sendingAmountController.text.toDouble} ${LocalStorage.getBaseCurrency()}",
      charges: Strings.charges.tr,
      chargeRate: "${controller.fees.value} ${LocalStorage.getBaseCurrency()}",
      received: Strings.youWillGet.tr,
      receivedRow:
          "${double.parse(controller.sendingAmountController.text).toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()}",
      total: Strings.totalPayable.tr,
      totalRow: "$total ${LocalStorage.getBaseCurrency()}",
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 1.5,
      ),
      child: Obx(
        () => controller.isUpdateLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.confirm.tr,
                onPressed: () => controller.transferProcess(),
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }
}
