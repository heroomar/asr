import 'package:crypinvest/utils/basic_screen_imports.dart';

import '../text_labels/title_heading5_widget.dart';
import 'progress_row.dart';

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
    required this.dollar,
    required this.component1,
    required this.component2,
    required this.component3,
    required this.component4,
    required this.component5,
    required this.component6,
    this.min,
    required this.tag,
    required this.onTap,
    this.decoration,
  });
  final String dollar,
      component1,
      component2,
      component3,
      component4,
      component5,
      component6,
      tag;
  final VoidCallback onTap;
  final String? min;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.45,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.4,
              vertical: Dimensions.paddingSize * 0.6,
            ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.24)),
              gradient: gradientBackground(),
              shadows: boxShadow(),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    //Dollar
                    TitleHeading3Widget(
                      padding:
                          EdgeInsets.only(top: Dimensions.paddingSize * 0.3),
                      text: Strings.form,
                      fontSize: Dimensions.headingTextSize6 - 1,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w600,
                    ),
                    Text(
                      ' \$$dollar',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CustomColor.primaryLightColor,
                        fontSize: Dimensions.headingTextSize4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 4),
                //drawer
                ProgressPlan(title: component1),
                ProgressPlan(title: component5),
                ProgressPlan(title: component2),
                ProgressPlan(title: component3),
                ProgressPlan(title: component4),
                ProgressPlan(title: component6),

                verticalSpace(Dimensions.heightSize * 0.6),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    width: Dimensions.widthSize * 10,
                    height: Dimensions.heightSize * 2.2,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: CustomColor.primaryLightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 0.6),
                      ),
                    ),
                    child: TitleHeading3Widget(
                      text: Strings.choosePlan,
                      fontSize: Dimensions.headingTextSize6 * 1.1,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              left: 0,
              top: 35.17.h,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width * 0.45,
                  Dimensions.heightSize * 2,
                ),
                painter: RPSCustomPainter(),
              )),
          Positioned(
            left: 0,
            right: 0,
            top: 40.h,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: TitleHeading3Widget(
                textAlign: TextAlign.center,
                text: tag,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                color: CustomColor.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.05720739, size.height * 0.03813156);
    path_0.cubicTo(
        size.width * 0.05720739,
        size.height * 0.03813156,
        size.width * 0.04081295,
        size.height * 0.08965750,
        size.width * 0.005681818,
        size.height * 0.2035944);
    path_0.moveTo(size.width * 0.005681818, size.height * 0.2035944);
    path_0.cubicTo(
        size.width * 0.3918994,
        size.height * 0.1887153,
        size.width * 0.9946534,
        size.height * 0.2162944,
        size.width * 0.9946534,
        size.height * 0.2162944);
    path_0.moveTo(size.width * 0.005681818, size.height * 0.2035944);
    path_0.cubicTo(
        size.width * 0.005681818,
        size.height * 0.4813344,
        size.width * 0.005681818,
        size.height * 0.9655938,
        size.width * 0.005681818,
        size.height * 0.9655938);
    path_0.lineTo(size.width * 0.9946534, size.height * 0.9655938);
    path_0.lineTo(size.width * 0.9946534, size.height * 0.2162944);
    path_0.moveTo(size.width * 0.9946534, size.height * 0.2162944);
    path_0.lineTo(size.width * 0.9425114, size.height * 0.03813156);

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.009368295;
    paint0Stroke.color = const Color(0xffB752F1).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xFFB752F1).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
