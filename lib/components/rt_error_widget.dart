import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';

class RTErrorWidget extends StatelessWidget {
  final Future<void> Function()? onTryAgain;
  const RTErrorWidget({super.key, this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(RTSizesType.xxl.size),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: RTSizesType.xxxg.size, child: SvgPicture.asset(Assets.svg.notFound)),
          RTSizesType.xg.spacer,
          Text(
            AppLocalizations.of(context)!.errorMessage,
            textAlign: TextAlign.center,
          ),
          if (onTryAgain != null)
            Padding(
              padding: EdgeInsets.only(top: RTSizesType.m.size),
              child: TextButton(
                onPressed: () => onTryAgain!(),
                child: Text(
                  AppLocalizations.of(context)!.rtTryAgain,
                  style: RTTextStyle.textButton(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
