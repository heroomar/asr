import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import '../../controller/sign_out/sign_out_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../others/custom_image_widget.dart';
import 'custom_dialoge_widget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Drawer(child: GradientContainer(child: _allItemListView(context)));
  }

  _allItemListView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize * .3,
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: Dimensions.heightSize * 2),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.primaryLightColor,
          ),
          alignment: Alignment.topLeft,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userImage(context),
            verticalSpace(Dimensions.heightSize * 0.5),
            TitleHeading2Widget(
              text: LocalStorage.getUsername()!,
              color: CustomColor.greyBlackColor,
            ),
            verticalSpace(Dimensions.heightSize * 0.2),
            TitleHeading4Widget(
              text: LocalStorage.getEmail()!,
              opacity: 0.5,
              color: CustomColor.greyBlackColor,
            ),
            verticalSpace(Dimensions.heightSize),
          ],
        ),
        _drawerItems(context),
      ],
    );
  }

  _userImage(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: Dimensions.paddingSize * 0.5,
          bottom: Dimensions.paddingSize,
        ),
        height: Dimensions.heightSize * 8.3,
        width: Dimensions.widthSize * 11.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
          border: Border.all(color: CustomColor.primaryLightColor, width: 4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          child: FadeInImage(
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            image: NetworkImage(LocalStorage.getImage()!),
            placeholder: AssetImage(
              Assets.clipart.sampleProfile.path,
            ),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                Assets.clipart.sampleProfile.path,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }

  buildMenuItem(
    BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onTap,
    double scaleImage = 1,
  }) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * .5),
          child: ListTile(
            dense: true,
            leading: CustomImageWidget(
              path: imagePath,
              height: Dimensions.heightSize * 2.7,
              width: Dimensions.widthSize * 3,
            ),
            title: TitleHeading3Widget(
                text: title, color: CustomColor.greyBlackColor),
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  _drawerItems(BuildContext context) {
    final logOutController = Get.put(LogOutController());
    return Column(
      children: [
        buildMenuItem(
          context,
          imagePath: Assets.icon.myInvestIcon,
          title: Strings.myInvest.tr,
          onTap: () {
            LocalStorage.saveInvestRoute(investRoute: false);
            Get.toNamed(Routes.myInvestScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.profitLogIcon,
          title: Strings.profitLog.tr,
          onTap: () => Get.toNamed(Routes.profitLogScreen),
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.transactionLogIcon,
          title: Strings.transactionLog.tr,
          onTap: () => Get.toNamed(Routes.transactionsLogScreen),
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.settingIcon,
          title: Strings.settings.tr,
          onTap: () => Get.toNamed(Routes.settingsScreen),
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.helpCenterIcon,
          title: Strings.helpCenter.tr,
          onTap: () => Get.toNamed(Routes.helpCenter),
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.privacyPolicyIcon,
          title: Strings.privacyAndPolicy.tr,
          onTap: () => Get.toNamed(Routes.privacyPolicy),
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.aboutUsIcon,
          title: Strings.aboutUs.tr,
          onTap: () => Get.toNamed(Routes.aboutUs),
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.signOutIcon,
          title: Strings.signOut.tr,
          onTap: () {
            CustomDialog.show(
                title: Strings.signOutAlert,
                subtitle: Strings.doYouSignOut,
                cancelOnTap: () {
                  Get.back();
                },
                confirmOnTap: () {
                  logOutController.logOutProcess();
                });
          },
        ),
      ],
    );
  }
}
