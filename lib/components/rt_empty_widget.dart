import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';

class RTEmptyWidget extends StatelessWidget {
  const RTEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RTSizesType.xxl.size),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: RTSizesType.xxxg.size,
            child: Icon(Icons.search, size: RTSizesType.xxxg.size),
          ),
          RTSizesType.xxxl.spacer,
          Text(
            AppLocalizations.of(context)!.emptyMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
