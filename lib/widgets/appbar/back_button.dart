import '../../utils/basic_widget_imports.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * .5),
      onPressed: onTap,
      icon: CircleAvatar(
        radius: Dimensions.radius * 1.2,
        backgroundColor: CustomColor.primaryLightColor,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * .3),
          child: Icon(
            Icons.arrow_back_ios,
            color: CustomColor.whiteColor,
            size: Dimensions.heightSize,
            weight: Dimensions.widthSize * 2,
          ),
        ),
      ),
    );
  }
}
