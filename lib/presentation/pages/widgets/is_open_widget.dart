import 'package:flutter/material.dart';

class IsOpenWidget extends StatelessWidget {
  final bool isOpen;
  const IsOpenWidget({Key? key, required this.isOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(isOpen ? 'Open Now' : 'Closed',style: const TextStyle(fontStyle: FontStyle.italic),),
        const SizedBox(width: 5,),
        Icon(
          Icons.circle,
          color: isOpen ? Colors.green : Colors.red,
          size: 10,
        ),
      ],
    );
  }
}
