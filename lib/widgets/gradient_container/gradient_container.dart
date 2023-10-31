import '../../utils/basic_screen_imports.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, this.child, this.colors});

  final Widget? child;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradientBackground()),
      child: child,
    );
  }
}
