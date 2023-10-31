import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

class ProgressPlan extends StatelessWidget {
  const ProgressPlan({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.paddingSize * 0.1),
      child: Row(
        mainAxisAlignment: mainStart,
        children: [
          Expanded(
            flex: 1,
            child: CustomImageWidget(
              path: Assets.icon.mdiProgressTick,
              color: CustomColor.primaryDarkColor,
            ),
          ),
          horizontalSpace(Dimensions.widthSize * 0.5),
          Expanded(
            flex: 6,
            child: TitleHeading4Widget(
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              text: title,
              fontSize: Dimensions.headingTextSize6 * 0.824,
              fontWeight: FontWeight.w500,
              color: CustomColor.greyBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
