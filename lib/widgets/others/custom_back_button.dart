import '../../utils/basic_screen_imports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //  horizontalSpace(Dimensions.widthSize),
        InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: Dimensions.radius * 1.2,
              backgroundColor: CustomColor.primaryLightColor,
              child: Padding(
                padding: EdgeInsets.only(left: Dimensions.paddingSize * .2),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: CustomColor.whiteColor,
                  size: Dimensions.heightSize,
                  weight: Dimensions.widthSize * 2,
                ),
              ),
            )),
      ],
    );
  }
}