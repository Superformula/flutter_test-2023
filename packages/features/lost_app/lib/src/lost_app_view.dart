import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lost_app/src/assets.dart';
import 'package:lost_app/src/l10n/lost_app_localizations.dart';

class LostAppView extends StatelessWidget {
  const LostAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = LostAppLocalizations.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox.square(
              dimension: 200,
              child: SvgPicture.asset(Assets.appGotLostPath),
            ),
            Text(l10n.appLostMessage),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
