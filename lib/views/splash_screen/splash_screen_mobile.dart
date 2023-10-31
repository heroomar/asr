import 'package:crypinvest/custom_assets/assets.gen.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../backend/backend_utils/custom_loading_api.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../controller/app_settings/app_setting_controller.dart';
import '../../utils/basic_screen_imports.dart';

class SplashScreenMobile extends StatelessWidget {
  SplashScreenMobile({Key? key}) : super(key: key);

  final controller = Get.put(AppSettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.transparentColor,
      body: Obx(
        () => controller.isLoading
            ? const GradientContainer(child: CustomLoadingAPI())
            : Stack(
                children: [
                  const GradientContainer(
                    colors: [
                      CustomColor.splashBackgroundGradientTopColor,
                      CustomColor.splashBackgroundGradientBottomColor,
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(Assets.onboard.onboardNew.path,
                        height: 138.h, width: 178.w),
                  )
                ],
              ),
      ),
    );
  }
}
