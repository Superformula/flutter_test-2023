import 'package:flutter/material.dart';

class AppErrorRefreshWidget extends StatelessWidget {
  const AppErrorRefreshWidget({
    Key? key,
    this.errorMessage,
    this.onRefresh,
  }) : super(key: key);

  final String? errorMessage;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        GestureDetector(
          onTap: () async {
            if (onRefresh != null) {
              onRefresh!();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.refresh,
                size: 32,
              ),
              Text(
                'Refresh',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
