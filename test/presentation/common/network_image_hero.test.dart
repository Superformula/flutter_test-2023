import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/presentation/common/network_hero/network_image_hero.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets(
    'NetworkImageHero displays a hero with the provided hero tag',
    (WidgetTester tester) async {
      const String? imageLink = null;
      const String heroId = 'hero_id';

      await tester.pumpWidget(
        const MaterialApp(
          home: NetworkImageHero(
            imageLink: imageLink,
            heroId: heroId,
          ),
        ),
      );

      final heroWidget = find.byType(Hero);
      expect(heroWidget, findsOneWidget);
      final hero = tester.widget(heroWidget) as Hero;
      expect(hero.tag, heroId);
    },
  );

  testWidgets(
    'NetworkImageHero displays Image from network when imageLink is provided',
    (WidgetTester tester) async {
      const String imageLink =
          'https://s3-media1.fl.yelpcdn.com/bphoto/V_zmwCUG1o_vR29xfkb-ng/o.jpg';
      const String heroId = 'hero_id';

      await tester.pumpWidget(
        const MaterialApp(
          home: NetworkImageHero(
            imageLink: imageLink,
            heroId: heroId,
          ),
        ),
      );

      final imageWidget = find.byType(Image);
      expect(imageWidget, findsOneWidget);
      final image = tester.widget(imageWidget) as Image;
      expect(image.image, isA<NetworkImage>());
    },
  );

  testWidgets(
    'NetworkImageHero displays placeholder when imageLink is null',
    (WidgetTester tester) async {
      const String? imageLink = null;
      const String heroId = 'hero_id';

      await tester.pumpWidget(
        const MaterialApp(
          home: NetworkImageHero(
            imageLink: imageLink,
            heroId: heroId,
          ),
        ),
      );

      final container = find.byType(Container);
      final icon = find.byIcon(Icons.restaurant_outlined);

      expect(container, findsOneWidget);
      expect(icon, findsOneWidget);
    },
  );
}
