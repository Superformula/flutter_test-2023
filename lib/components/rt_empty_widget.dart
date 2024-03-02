import 'package:restaurantour/core/core.dart';

class RTEmptyWidget extends StatelessWidget {
  const RTEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
            child: Icon(Icons.search, size: 80),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.emptyMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
