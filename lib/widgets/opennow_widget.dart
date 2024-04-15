import 'package:flutter/material.dart';

class OpenNowWidget extends StatelessWidget {
  bool isOpen;
  OpenNowWidget({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isOpen ? "Open now" : " Closed",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 5,
            ),
            child: Icon(
              Icons.circle,
              color: isOpen ? Colors.greenAccent : Colors.redAccent,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
