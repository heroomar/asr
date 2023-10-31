import 'package:crypinvest/utils/basic_screen_imports.dart';
import 'package:crypinvest/widgets/others/custom_image_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});
  final String icon, title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.marginSizeHorizontal * 0.5),
        child: Column(
          mainAxisAlignment: mainCenter,
          mainAxisSize: mainMin,
          children: [
            Container(
              alignment: Alignment.center,
              width: Dimensions.widthSize * 5,
              height: Dimensions.heightSize * 4,
              decoration: ShapeDecoration(
                color: CustomColor.primaryLightColor.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.12),
                ),
              ),
              child: CustomImageWidget(
                path: icon,
                height: Dimensions.heightSize * 1.7,
                width: Dimensions.heightSize * 1.9,
                color: CustomColor.primaryLightColor,
              ),
            ),
            verticalSpace(Dimensions.heightSize),
            TitleHeading3Widget(
              text: title,
              fontWeight: FontWeight.w600,
              color: CustomColor.greyBlackColor,
              fontSize: Dimensions.headingTextSize5 - 1,
            ),
          ],
        ),
      ),
    );
  }
}
