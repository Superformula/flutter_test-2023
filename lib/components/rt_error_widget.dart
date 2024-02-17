import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RTErrorWidget extends StatelessWidget {
  const RTErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100, child: SvgPicture.asset('assets/svg/404.svg')),
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.errorMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
