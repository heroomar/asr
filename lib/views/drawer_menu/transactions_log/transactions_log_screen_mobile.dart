// ignore_for_file: depend_on_referenced_packages

import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/drawer/transaction_log_widget.dart';
import '../../../controller/drawer/transaction_log_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../../../widgets/others/no_data_widget.dart';

class TransactionsLogScreenMobile extends StatelessWidget {
  TransactionsLogScreenMobile({super.key});
  final controller = Get.put(TransactionLogController());
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.transactionLog.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return _transactionLogWidget(context);
  }

  _transactionLogWidget(BuildContext context) {
    var data = controller.transactionModel.data.transactions;
    return data.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return TransactionLogWidget(
                color: data[index].status == 2
                    ? CustomColor.primaryLightColor
                    : data[index].status == 1
                        ? CustomColor.greenColor
                        : CustomColor.redColor,
                transactionType: data[index].type,
                transactionId: data[index].trxId,
                monthText:
                    DateFormat("MMMM").format(data[index].createdAt).toString(),
                dateText:
                    DateFormat("d").format(data[index].createdAt).toString(),
                status: data[index].status == 2
                    ? Strings.pending
                    : data[index].status == 1
                        ? Strings.success
                        : Strings.rejected,
                amount:
                    "${double.parse(data[index].receiveAmount).toStringAsFixed(1)} ${data[index].requestCurrency}",
              );
            },
          )
        : const NoDataWidget();
  }
}
