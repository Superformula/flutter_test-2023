import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:restaurantour/core/utils/dependency_injector.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/domain/controllers/details_restaurant_controller.dart';
import 'package:restaurantour/modules/home/domain/stores/favorite_store.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utils/constants.dart';
import 'widgets/circular_progress_widget.dart';

class DetailsRestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  const DetailsRestaurantPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailsRestaurantPage> createState() => _DetailsRestaurantPageState();
}

class _DetailsRestaurantPageState extends State<DetailsRestaurantPage> {
  final DetailsRestaurantController controller = locator.get<DetailsRestaurantController>();
  final FavoriteStore favoriteStore = locator.get<FavoriteStore>();

  @override
  void initState() {
    controller.loadRestaurant(widget.restaurant);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (context) {
            return Text(
              key: const Key(ConstantsApp.kTitleDetailsRestaurant),
              controller.status.isLoading ? '' : widget.restaurant.name ?? '',
            );
          },
        ),
        actions: [
          Observer(
            builder: (context) {
              final bool isFavorite = favoriteStore.restaurantsFavorits
                      .firstWhereOrNull((element) => element.id == controller.restaurant.id) !=
                  null;
              return Offstage(
                offstage: !controller.status.isSuccess,
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () async {
                    final bool isFavorite = favoriteStore.restaurantsFavorits
                            .firstWhereOrNull((element) => element.id == controller.restaurant.id) !=
                        null;
                    if (isFavorite) {
                      favoriteStore.removeFavorite(controller.restaurant);
                    } else {
                      favoriteStore.addFavorite(controller.restaurant);
                    }
                  },
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                ),
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (controller.status.isLoading) return const CircularProgressWidget();

          if (controller.status.isFailure) {
            return Center(
              key: const Key(ConstantsApp.kErrorDetailsRestaurant),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Icon(Icons.error_outline, size: 120, color: AppTheme.redColor.withOpacity(0.7)),
                    const SizedBox(height: 16),
                    const Text(
                      'Error returning to restaurant,\nplease try again later.',
                      style: AppTextStyle.black14w600,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.loadRestaurant(controller.restaurant),
                      child: const Text('REFRESH', style: AppTextStyle.black16w600),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            children: [
              controller.restaurant.heroImage.isEmpty
                  ? Container(
                      color: Colors.grey.shade300,
                      height: 361,
                      width: double.maxFinite,
                      child: const Icon(Icons.image_not_supported_outlined, color: Colors.black54, size: 150),
                    )
                  : Hero(
                      tag: controller.restaurant.heroImage,
                      child: CachedNetworkImage(
                        imageUrl: controller.restaurant.heroImage,
                        height: 361,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) => const CircularProgressWidget(),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(controller.restaurant.displayCategory, style: AppTextStyle.black12w400OpenSans),
                        const Spacer(),
                        Text(
                          controller.restaurant.isOpen ? 'Open Now' : 'Closed',
                          style: AppTextStyle.black12w400OpenSans.copyWith(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 3),
                          child: CircleAvatar(
                            backgroundColor: controller.restaurant.isOpen ? AppTheme.greenColor : AppTheme.redColor,
                            radius: 4,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                    const Text('Address', style: AppTextStyle.black12w400OpenSans),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        controller.restaurant.location?.formattedAddress ?? '',
                        style: AppTextStyle.black14w600OpenSans,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                    const Text('Overall Rating', style: AppTextStyle.black12w400OpenSans),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Text(
                            '${controller.restaurant.rating ?? 0}',
                            style: AppTextStyle.black18w700.copyWith(fontSize: 28),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(Icons.star, color: AppTheme.yellowColor, size: 16),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                    if ((controller.restaurant.reviews?.length ?? 0) > 0) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          (controller.restaurant.reviews?.length ?? 0) == 1
                              ? '1 Review'
                              : '${controller.restaurant.reviews?.length} Reviews',
                          style: AppTextStyle.black12w400OpenSans,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.restaurant.reviews!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(),
                        ),
                        itemBuilder: (context, index) {
                          final review = controller.restaurant.reviews![index];
                          return Column(
                            key: Key('${ConstantsApp.kReviewsRestaurant}_$index'),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: List.generate(
                                  review.rating?.round() ?? 0,
                                  (index) => const Icon(Icons.star, color: AppTheme.yellowColor, size: 16),
                                ).toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  review.text ?? '',
                                  style: AppTextStyle.black14w400OpenSans.copyWith(fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                                    child: (review.user?.imageUrl ?? '').isEmpty
                                        ? const Icon(Icons.image_not_supported_outlined, color: Colors.black54)
                                        : CachedNetworkImage(
                                            imageUrl: review.user?.imageUrl ?? '',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, progress) =>
                                                const CircularProgressWidget(),
                                          ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(review.user?.name ?? '', style: AppTextStyle.black12w400OpenSans),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
