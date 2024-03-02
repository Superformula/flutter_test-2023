import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';

class RTErrorWidget extends StatelessWidget {
  final Future<void> Function()? onTryAgain;
  const RTErrorWidget({super.key, this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80, child: SvgPicture.asset('assets/svg/404.svg')),
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.errorMessage,
            textAlign: TextAlign.center,
          ),
          if (onTryAgain != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ElevatedButton(
                onPressed: () => onTryAgain!(),
                child: Text(
                  AppLocalizations.of(context)!.rtTryAgain,
                  style: RTTextStyle.button(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
