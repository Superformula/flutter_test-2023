import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Oops, looks like there's nothing here yet..",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
