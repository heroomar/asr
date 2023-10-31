import 'package:crypinvest/extensions/context_ext.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          Assets.background.noData.path,
          height: context.h * .7,
          width: context.w * .7,
        ),
        // child: TitleHeading3Widget(
        //   text: Strings.emptyStatus,
        //   color: CustomColor.primaryDarkColor.withOpacity(0.6),
        // ),
      ),
    );
  }
}
