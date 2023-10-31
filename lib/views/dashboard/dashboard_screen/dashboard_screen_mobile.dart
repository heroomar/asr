// ignore_for_file: depend_on_referenced_packages

import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:crypinvest/backend/model/dashbaord/dashboard_model.dart';
import 'package:crypinvest/widgets/dashboard/custom_glass_widget.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../controller/dashboard/dashboard_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../data/dashboard/categoreis_data.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../../widgets/dashboard/addmoney_money_out_widget.dart';
import '../../../widgets/dashboard/card_widget.dart';
import '../../../widgets/dashboard/categories_widget.dart';
import '../../../widgets/drawer/drawer_widget.dart';
import '../../../widgets/drawer/transaction_log_widget.dart';
import '../../../widgets/others/custom_image_widget.dart';
import 'package:intl/intl.dart';

class DashboardScreenMobile extends StatelessWidget {
  DashboardScreenMobile({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: GradientContainer(
        child: Scaffold(
          drawer: DrawerWidget(),
          key: scaffoldKey,
          extendBody: true,
          backgroundColor: CustomColor.transparentColor,
          appBar: appBarWidget(context),
          body: Obx(
            () => controller.isLoading
                ? const CustomLoadingAPI()
                : _bodyWidget(context),
          ),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          color: CustomColor.whiteColor,
          backgroundColor: CustomColor.primaryLightColor,
          strokeWidth: 2.5,
          onRefresh: () async {
            controller.getDashboardData();
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: ListView(
            padding: EdgeInsets.only(top: Dimensions.paddingSize * .5),
            children: [
              _cardButtonWidget(context),
              _categoriesWidget(context),
              _chartWidget(context),
              const AddMoneyMoneyOutWidget(),
            ],
          ),
        ),
        _draggableSheet(context),
      ],
    );
  }

  _draggableSheet(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (_, scrollController) {
        return _transactionWidget(context, scrollController);
      },
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 1,
    );
  }

  _cardButtonWidget(BuildContext context) {
    var data = controller.dashboardModel.data.cards;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .23,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: Dimensions.marginSizeHorizontal * 0.6),
        children: [
          CardWidget(
            title: data.cBalance.title,
            balance:
                "${double.parse(data.cBalance.amount).toStringAsFixed(2)} ASR",
            buttonText: Strings.addMoney,
            onTap: () {
              Get.toNamed(Routes.addMoneyScreen);
            },
          ),
          CardWidget(
            title: data.pBalance.title,
            balance:
                "${double.parse(data.pBalance.amount).toStringAsFixed(2)} ASR",
            buttonText: Strings.moneyOut,
            onTap: () {
              Get.toNamed(Routes.moneyOutScreen);
            },
          ),
          CardWidget(
            title: 'Staking Balance',
            balance:
                "${double.parse(data.iBalance.amount).toStringAsFixed(2)} ASR",
            buttonText: Strings.investment,
            onTap: () => Get.toNamed(Routes.investPlanScreen),
          ),
        ],
      ),
    );
  }

  _categoriesWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: Dimensions.marginSizeHorizontal * 0.7,
          right: Dimensions.marginSizeHorizontal * 0.5,
          top: Dimensions.marginSizeHorizontal * 0.5,
        ),
        height: MediaQuery.sizeOf(context).height * 0.11,
        child: Wrap(
          children: List.generate(
            categoriesData.length,
            (index) => CategoriesWidget(
              onTap: categoriesData[index].onTap,
              icon: categoriesData[index].icon,
              title: categoriesData[index].title,
            ),
          ),
        ));
  }

  _chartWidget(BuildContext context) {
    //var data=controller.dashboardModel.data.chartData;
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.3),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: SfCartesianChart(
          plotAreaBackgroundColor:
              CustomColor.primaryLightColor.withOpacity(0.025),
          primaryXAxis: CategoryAxis(),
          series: <AreaSeries<Statistic, String>>[
            AreaSeries<Statistic, String>(
              // Bind data
              borderColor: CustomColor.primaryLightColor,
              borderWidth: 1,
              dataSource: <Statistic>[
                ...controller.addMoneyData,
              ],
              xValueMapper: (Statistic sales, _) =>
                  DateFormat("d MMM").format(sales.timestamp).toString(),
              yValueMapper: (Statistic sales, _) => double.parse(sales.value),
              color: CustomColor.primaryLightColor.withOpacity(0.6),
            ),
            AreaSeries<Statistic, String>(
              // Bind data source

              borderColor: CustomColor.secondaryDarkColor,
              borderWidth: 1,
              dataSource: <Statistic>[
                ...controller.moneyOutData,
              ],
              xValueMapper: (Statistic sales, _) =>
                  DateFormat("d MMM").format(sales.timestamp).toString(),
              yValueMapper: (Statistic sales, _) => double.parse(sales.value),
              color: CustomColor.yellowColor.withOpacity(0.6),
            )
          ],
        ),

        //add money and money out widget
      ),
    );
  }

  _transactionWidget(BuildContext context, ScrollController scrollController) {
    var data = controller.dashboardModel.data.recentTransactions;
    return data.isNotEmpty
        ? ListView(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              verticalSpace(Dimensions.heightSize * 0.5),
              CustomTitleHeadingWidget(
                text: Strings.recentTransaction,
                style: Get.isDarkMode
                    ? CustomStyle.lightHeading3TextStyle.copyWith(
                        fontSize: Dimensions.headingTextSize2,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.greyBlackColor)
                    : CustomStyle.darkHeading3TextStyle.copyWith(
                        fontSize: Dimensions.headingTextSize2,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.greyBlackColor),
              ),
              verticalSpace(Dimensions.widthSize),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    controller: scrollController,
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
                        monthText: DateFormat("MMMM")
                            .format(data[index].createdAt)
                            .toString(),
                        dateText: DateFormat("d")
                            .format(data[index].createdAt)
                            .toString(),
                        status: data[index].status == 2
                            ? Strings.pending
                            : data[index].status == 1
                                ? Strings.success
                                : Strings.rejected,
                        amount:
                            "${double.parse(data[index].receiveAmount).toStringAsFixed(1)} ${data[index].requestCurrency}",
                      );
                    }),
              )
            ],
          ).customGlassWidget()
        : const SizedBox.shrink();
  }

  appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.transparentColor,
      elevation: 0,
      centerTitle: true,
      leading: InkWell(
        splashColor: Colors.transparent,
        highlightColor: CustomColor.transparentColor,
        onTap: () => scaffoldKey.currentState!.openDrawer(),
        child: Padding(
            padding: EdgeInsets.only(
                left: Dimensions.paddingSize,
                right: Dimensions.paddingSize * 0.2),
            child: CustomImageWidget(
              path: Assets.icon.drawer,
              height: Dimensions.heightSize * 1.3,
              width: Dimensions.heightSize * 1.5,
              color: CustomColor.primaryLightColor,
            )),
      ),
      title: Image.asset(
        Assets.onboard.onboardNew.path,
        height: MediaQuery.of(context).size.height * .20,
        width: MediaQuery.of(context).size.width * .23,
      ),
      actions: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.6),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.updateProfileScreen);
            },
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .5),
              child: Padding(
                padding: EdgeInsets.only(right: Dimensions.paddingSize * .25),
                child: CustomImageWidget(
                  path: Assets.icon.profileSvg,
                  height: Dimensions.heightSize * 2,
                  width: Dimensions.widthSize * 3,
                  color: CustomColor.primaryDarkColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
