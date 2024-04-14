import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

class CustomSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const CustomSnackBar(this.message, this.type, {Key? key}) : super(key: key);

  Color getSnackBarColor() {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.info:
      default:
        return Colors.black26;
    }
  }

  void displaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        margin: const EdgeInsets.only(
          bottom: 0.0,
          right: 24,
          left: 24,
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: getSnackBarColor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    displaySnackBar(context);
    return const SizedBox();
  }
}
