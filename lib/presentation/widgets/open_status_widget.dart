import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OpenStatusWidget extends StatelessWidget {
  final bool isOpen;

  const OpenStatusWidget({Key? key, required this.isOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isOpen ? 'Open Now' : 'Closed',
          style: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(width: 4),
        SvgPicture.asset(
          isOpen ? 'assets/svg/circle_green.svg' : 'assets/svg/circle_red.svg',
        ),
      ],
    );
  }
}
