// ignore_for_file: depend_on_referenced_packages

import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/drawer/profit_log_widget.dart';
import '../../../controller/drawer/profit_log_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../../../widgets/gradient_container/gradient_container.dart';
import '../../../widgets/others/no_data_widget.dart';

class ProfitLogScreenMobile extends StatelessWidget {
  ProfitLogScreenMobile({super.key});
  final controller = Get.put(ProfitLogController());
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.profitLog.tr,
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
    return _profitLogWidget(context);
  }

  _profitLogWidget(BuildContext context) {
    var data = controller.profitLogModel.data.profitLogs;
    return data.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ProfitLogWidget(
                title: data[index].invest.investPlan.name,
                monthText:
                    DateFormat("MMMM").format(data[index].createdAt).toString(),
                dateText:
                    DateFormat("d").format(data[index].createdAt).toString(),
                investmentAmount: double.parse(data[index].invest.investAmount)
                    .toStringAsFixed(2),
                profitAmount:
                    double.parse(data[index].profitAmount).toStringAsFixed(2),
              );
            },
          )
        : const NoDataWidget();
  }
}
