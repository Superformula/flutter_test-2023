import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  static const String text = "Oops, looks like there's nothing here yet..";
  const NoDataFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
