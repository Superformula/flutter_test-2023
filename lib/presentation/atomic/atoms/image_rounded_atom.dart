part of 'package.dart';

class ImageRoundedAtom extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  const ImageRoundedAtom({
    super.key,
    required this.url,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
