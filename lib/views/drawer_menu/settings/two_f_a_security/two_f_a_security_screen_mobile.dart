// ignore_for_file: deprecated_member_use

import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/services/api_endpoint.dart';
import '../../../../controller/drawer/two_f_a_security_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class TwoFASecurityScreenMobile extends StatelessWidget {
  TwoFASecurityScreenMobile({super.key});
  final controller = Get.put(TwoFASecurityController());
  final twoFAFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '',
          titleClr: CustomColor.primaryLightColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () {
            Get.back();
          },
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
      child: ListView(
        children: [
          _enableTwoFATitleAndSubtitleWidget(context),
        ],
      ),
    );
  }

  _enableTwoFATitleAndSubtitleWidget(BuildContext context) {
    var data = controller.googleTwoFaModel.data.message;
    return InkWell(
      onTap: () {
        launch("${ApiEndpoint.mainDomain}/authorize/google/2fa");
      },
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TitleHeading2Widget(
            padding: EdgeInsets.only(
                top: Dimensions.paddingSize * .75,
                bottom: Dimensions.paddingSize * .5),
            text: Strings.enableTwoFASecurity,
            color: CustomColor.primaryDarkColor,
          ),
          TitleHeading5Widget(
            padding: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
            text: data,
            color: CustomColor.greyBlackColor.withOpacity(.40),
          )
        ],
      ),
    );
  }
}
