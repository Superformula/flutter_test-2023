import 'package:shimmer/shimmer.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/theme/theme.dart';

class RTShimmerLoading extends StatelessWidget {
  const RTShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFD8D8D8),
        highlightColor: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(strokeAlign: 1, color: RTColors.dividerLine),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        height: 104,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 88,
                width: 88,
                decoration: const BoxDecoration(
                  color: RTColors.placeholder,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: RTColors.placeholder),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 18,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: RTColors.placeholder),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Container(
                        height: 18,
                        width: 40,
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: RTColors.placeholder),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 80,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: RTColors.placeholder),
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
