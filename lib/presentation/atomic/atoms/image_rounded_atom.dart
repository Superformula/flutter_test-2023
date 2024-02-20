part of 'package.dart';

class ImageRoundedAtom extends StatefulWidget {
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
  State<ImageRoundedAtom> createState() => _ImageRoundedAtomState();
}

class _ImageRoundedAtomState extends State<ImageRoundedAtom> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: Image.network(
        widget.url,
        height: widget.height,
        width: widget.width,
        fit: BoxFit.fitWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return ShimmerAtom(
            height: widget.height,
            width: widget.width,
          );
        },
      ),
    );
  }
}
