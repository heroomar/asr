import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/routes/routes.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:crypinvest/widgets/others/no_data_widget.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/dashboard/investment/investment_controller.dart';
import '../../../../data/plan_card/plan_card_data.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/plan/plan_widget.dart';

class InvestPlanMobileLayout extends StatelessWidget {
  InvestPlanMobileLayout({super.key});

  final controller = Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.investPlan.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSize * 0.4,
                  horizontal: Dimensions.paddingSize * 0.3),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSize * 0.17,
                    horizontal: Dimensions.paddingSize * 0.4),
                decoration: ShapeDecoration(
                  color: CustomColor.primaryLightColor.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.4),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    LocalStorage.saveInvestRoute(investRoute: false);
                    Get.toNamed(Routes.myInvestScreen);
                  },
                  child: TitleHeading4Widget(
                    text: Strings.myInvest,
                    color: CustomColor.primaryLightColor,
                    fontSize: Dimensions.headingTextSize6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
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
    var data = controller.investPlaneModel.data.plans;
    String currencySymbol = LocalStorage.getCurrencySymbol();
    return data.isNotEmpty
        ? ListView(
            padding: EdgeInsets.only(
              top: Dimensions.paddingSize * 0.6,
              left: Dimensions.paddingSize * 0.6,
              right: Dimensions.paddingSize * 0.6,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.88,
                child: GridView.count(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.6,
                  children: List.generate(
                    planCardData.length,
                    (index) => PlanWidget(
                      dollar: planCardData[index].amount.toString(),
                      tag: planCardData[index].planType,
                      component1: planCardData[index].component1,
                      component2: planCardData[index].component2,
                      component3: planCardData[index].component3,
                      component4: planCardData[index].component4,
                      component5: planCardData[index].component5,
                      component6: planCardData[index].component6,
                      onTap: () {
                        LocalStorage.saveSlug(slug: data[index].slug);
                        controller.slug.value = data[index].slug;
                        controller.maxInvest.value = data[index].maxInvest;
                        controller.minProfit.value = data[index].minInvest;
                        controller.minInvestOffer.value =
                            data[index].minInvestOffer;
                        controller.profitReturn.value = data[index].duration;
                        Get.toNamed(Routes.investmentScreen);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        : const NoDataWidget();
  }
}
