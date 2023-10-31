import 'package:crypinvest/language/language_controller.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../widgets/appbar/back_button.dart';

import '../../utils/basic_screen_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final VoidCallback onTap;
  final String? title;
  final bool centerTitle;
  final bool alwaysShowBackButton;
  final bool isWhiteBackButton;
  final double? elevation;
  final Color? bgClr;
  final Color? titleClr;
  final List<Widget>? actions;
  final controller = Get.put(LanguageController());
  CustomAppBar({
    Key? key,
    this.title,
    this.centerTitle = false,
    this.isWhiteBackButton = false,
    this.elevation = 1.8,
    this.bgClr = CustomColor.primaryLightScaffoldBackgroundColor,
    this.titleClr = CustomColor.whiteColor,
    this.alwaysShowBackButton = true,
    this.actions,
    required this.onTap,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        surfaceTintColor: CustomColor.primaryLightScaffoldBackgroundColor,
        leading: Visibility(
          visible: alwaysShowBackButton == true ? true : false,
          child: BackButtonWidget(
            onTap: onTap,
          ),
        ),
        title: Text(
          controller.getTranslation(title!),
          style: TextStyle(
            color: titleClr,
            fontSize: Dimensions.headingTextSize2,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: centerTitle,
        elevation: elevation,
        backgroundColor: bgClr,
        automaticallyImplyLeading: false,
        actions: actions,
      ),
    );
  }
}
