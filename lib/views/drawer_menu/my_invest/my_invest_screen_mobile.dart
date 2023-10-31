// ignore_for_file: depend_on_referenced_packages

import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:crypinvest/routes/routes.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:crypinvest/widgets/others/no_data_widget.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/drawer/my_invest_widget.dart';
import '../../../controller/dashboard/investment/my_invest_plan_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/custom_app_bar.dart';

class MyInvestScreenMobile extends StatelessWidget {
  MyInvestScreenMobile({super.key});
  final controller = Get.put(MyInvestmentPlaneController());

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.myInvest.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () {
            if (LocalStorage.getInvest() == true) {
              Get.offAllNamed(Routes.dashboardScreen);
            } else {
              Get.back();
            }
          },
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
    return _myInvestmentWidget(context);
  }

  _myInvestmentWidget(BuildContext context) {
    var data = controller.myInvestmentModel.data.investments;
    // var status = controller.myInvestmentModel.data.instructions;
    return data.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return MyInvestWidget(
                title: data[index].investPlan.name,
                dateText:
                    DateFormat("d").format(data[index].createdAt).toString(),
                investmentDays:
                    "${data[index].investPlan.duration} ${Strings.days}",
                monthText:
                    DateFormat("MMMM").format(data[index].createdAt).toString(),
                incomeStatement:
                    "${Strings.profit} ${double.parse(data[index].investPlan.profitFixed).toStringAsFixed(2)}",
                status: data[index].status == "2"
                    ? Strings.pending
                    : data[index].status == "1"
                        ? Strings.success
                        : Strings.rejected,
                color: data[index].status == "2"
                    ? CustomColor.primaryLightColor
                    : data[index].status == "1"
                        ? CustomColor.greenColor
                        : CustomColor.redColor,
                amount:
                    "${double.parse(data[index].investAmount).toStringAsFixed(1)} ${LocalStorage.getBaseCurrency()}",
              );
            },
          )
        : const NoDataWidget();
  }
}
