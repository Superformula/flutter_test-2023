import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class RTShimmerLoading extends StatelessWidget {
  const RTShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<RTThemeExtension>()!;
    return IgnorePointer(
      child: Shimmer.fromColors(
        baseColor: theme.shimmerBaseColor,
        highlightColor: theme.shimmerHighlightColor,
        child: Padding(
          padding: EdgeInsets.only(top: RTSizesType.xs.size),
          child: ListView(
            children: List.generate(15, (index) => const TileLoading()),
          ),
        ),
      ),
    );
  }
}

class TileLoading extends StatelessWidget {
  const TileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<RTThemeExtension>()!;

    return Padding(
      padding: EdgeInsets.all(RTSizesType.m.size),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(strokeAlign: RTSizesType.xxxxs.size, color: theme.dividerLineColor),
          borderRadius: BorderRadius.all(RTSizesType.s.radius),
        ),
        height: RTSizesType.xgg.size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(RTSizesType.s.size),
              child: Container(
                height: RTSizesType.gg.size,
                width: RTSizesType.gg.size,
                decoration: BoxDecoration(
                  color: theme.placeholderColor,
                  borderRadius: BorderRadius.all(RTSizesType.s.radius),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(RTSizesType.m.size),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: RTSizesType.xxl.size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(RTSizesType.s.radius),
                        color: theme.placeholderColor,
                      ),
                    ),
                    RTSizesType.xxs.spacer,
                    Container(
                      height: RTSizesType.xxl.size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(RTSizesType.s.radius),
                        color: theme.placeholderColor,
                      ),
                    ),
                    RTSizesType.xxs.spacer,
                    Expanded(
                      child: Container(
                        height: RTSizesType.xxl.size,
                        width: RTSizesType.xg.size,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(RTSizesType.s.radius),
                          color: theme.placeholderColor,
                        ),
                      ),
                    ),
                    RTSizesType.xxs.spacer,
                    Container(
                      height: RTSizesType.m.size,
                      width: RTSizesType.xxxg.size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(RTSizesType.s.radius),
                        color: theme.placeholderColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
