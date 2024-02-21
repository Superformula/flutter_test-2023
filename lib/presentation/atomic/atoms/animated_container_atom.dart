part of 'package.dart';

class AnimatedScrollableContainerAtom extends StatefulWidget {
  final double width;
  final double height;
  final ScrollController controller;
  final Widget child;
  const AnimatedScrollableContainerAtom({
    super.key,
    this.width = 50,
    this.height = 50,
    required this.controller,
    required this.child,
  });

  @override
  State<AnimatedScrollableContainerAtom> createState() =>
      _AnimatedScrollableContainerAtomState();
}

class _AnimatedScrollableContainerAtomState
    extends State<AnimatedScrollableContainerAtom> {
  late double _width;
  late double _height;
  late double _offset;
  @override
  void initState() {
    super.initState();
    _width = widget.width;
    _height = widget.height;
    _offset = widget.controller.offset;
    widget.controller.addListener(() {
      setState(() {
        if (widget.controller.offset > _offset) {
          _height++;
        } else {
          _height--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: _width,
      height: _height,
      // decoration: BoxDecoration(
      //   color: _color,
      //   borderRadius: _borderRadius,
      // ),
      // Define how long the animation should take.
      duration: const Duration(seconds: 1),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      child: widget.child,
    );
  }
}
