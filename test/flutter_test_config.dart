import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'utils/local_file_comparator_with_threshold.dart';

const runningOnCICD = bool.fromEnvironment('runningOnCICD', defaultValue: false);

const _kGoldenTestsThreshold = 0.01 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  if (goldenFileComparator is LocalFileComparator) {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    goldenFileComparator = LocalFileComparatorWithThreshold(Uri.parse('$testUrl/test.dart'), runningOnCICD ? _kGoldenTestsThreshold : 0.0);
  } else {
    throw Exception(
      'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
      'but it is of type `${goldenFileComparator.runtimeType}`',
    );
  }

  await testMain();
}
