part of 'package.dart';

class ShimmerAtom extends StatelessWidget {
  late final Widget _child;

  ShimmerAtom({
    super.key,
    double height = 50,
    double width = 50,
    EdgeInsetsGeometry? margin,
  }) {
    _child = _rectangular(height, width, margin);
  }

  static const _textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  ShimmerAtom.text(String text, {super.key, TextStyle style = _textStyle}) {
    _child = Text(text, style: style);
  }

  ShimmerAtom.circular({super.key, double radius = 30}) {
    _child = CircleAvatar(
      radius: radius,
    );
  }

  static Container _rectangular(
    double height,
    double width,
    EdgeInsetsGeometry? margin,
  ) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Opacity(opacity: 0.4, child: _shimmer());
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[500]!,
      child: _child,
    );
  }
}
