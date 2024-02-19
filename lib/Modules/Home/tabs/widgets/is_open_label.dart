import 'package:flutter/material.dart';

class IsOpenLabel extends StatelessWidget {
  const IsOpenLabel({Key? key, this.isOpen}) : super(key: key);

  final bool? isOpen;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => isOpen != null
          ? (isOpen!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Open Now',
                      key: Key('open_text'),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Closed',
                      key: Key('closed_text'),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ))
          : const Text(
              'not informed',
              key: Key('not_informed_text'),
              textAlign: TextAlign.right,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
    );
  }
}
