import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/dashboard/money_transfer/money_transfer_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class MoneyTransferScreenMobile extends StatelessWidget {
  MoneyTransferScreenMobile({super.key});

  final controller = Get.put(MoneyTransferController());
  final inputFormKey = GlobalKey<FormState>();

  final Color borderColor = Get.isDarkMode
      ? CustomColor.primaryDarkTextColor.withOpacity(.15)
      : CustomColor.primaryLightTextColor.withOpacity(.15);

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.moneyTransfer.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize,
        vertical: Dimensions.paddingSize,
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        _inputAndLimitWidget(context),
      ],
    );
  }

  _inputAndLimitWidget(BuildContext context) {
    return Form(
      key: inputFormKey,
      child: Column(
        children: [
          _sendingAmountWidget(context),
          _moneyTransferLimitWidget(context),
          _receiverEmailAddressWidget(context),
          _moneyTransferButtonWidget(context),
        ],
      ),
    );
  }

  _sendingAmountWidget(BuildContext context) {
    return PrimaryTextInputWidget(
      controller: controller.sendingAmountController,
      labelText: Strings.sendingAmount.tr,
      hintText: Strings.enterSendingAmount.tr,
      borderColor: CustomColor.greyBlackColor.withOpacity(.5),
      keyboardType: TextInputType.number,
      suffixIcon: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? CustomColor.primaryDarkColor
              : CustomColor.primaryLightColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 0.5),
            topRight: Radius.circular(Dimensions.radius * 0.5),
          ),
        ),
        width: Dimensions.widthSize * 8,
        child: Center(
          child: TitleHeading2Widget(
            text: LocalStorage.getBaseCurrency().toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _moneyTransferLimitWidget(BuildContext context) {
    var data = controller.moneyTransferWallet.data.charges;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingSize * .25,
      ),
      child: Row(
        mainAxisAlignment: mainStart,
        children: [
          TitleHeading5Widget(
            text:
                "${data.minLimit} ${LocalStorage.getBaseCurrency()} - ${data.maxLimit} ${LocalStorage.getBaseCurrency()}",
            color: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  _receiverEmailAddressWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingSize,
      ),
      child: PrimaryTextInputWidget(
        keyboardType: TextInputType.emailAddress,
        controller: controller.receiverEmailAddressController,
        hintText: Strings.enterReceiverEmailAddress,
        borderColor: CustomColor.greyBlackColor.withOpacity(.5),
        labelText: Strings.receiverEmailAddress,
      ),
    );
  }

  _moneyTransferButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .4),
      child: PrimaryButton(
        title: Strings.moneyTransfer.tr,
        onPressed: () {
          if (inputFormKey.currentState!.validate()) {
            controller.goToMoneyTransferPreviewScreen();
          }
        },
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor,
        buttonColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor,
      ),
    );
  }
}
