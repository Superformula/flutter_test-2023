# SETUP:
get :
	flutter pub get

setup-fvm-version :
	fvm install 3.16.8 && \
	fvm global 3.16.8

pre-setup :
	flutter clean &&\
	dart run build_runner clean && \
	dart pub global activate arb_utils && \
	dart pub global activate flutter_gen


setup-env-file :
	test -f .env || echo "API_KEY=''" >> .env

setup : pre-setup get l10n gen asset-gen setup-env-file unit-tests


fix-gen :
	mkdir -p .dart_tool/flutter_gen/ && echo "name: stub" > .dart_tool/flutter_gen/pubspec.yaml

try-fix-gen : fix-gen
	dart run build_runner build --delete-conflicting-outputs

# TESTS:

tests : 
	flutter test --coverage

all-tests : tests integration-tests

unit-tests : 
	flutter test -x golden --coverage

golden-tests :
	flutter test -t golden --coverage

tests-ci-cd : 
	rm -rf coverage && flutter test --coverage --dart-define=runningOnCICD=true

integration-tests : 
	flutter test integration_test/app_test.dart

update-goldens : remove-goldens-failures
	flutter test --update-goldens

remove-goldens-failures : 
	rm test/golden_test/failures/*

# TEST COVERAGE

show-coverage : tests lcov

lcov-ignore : 
	lcov --remove coverage/lcov.info 'lib/core/*' 'lib/theme/*' 'lib/models/*.g.dart' -o coverage/lcov.info

lcov : tests lcov-ignore
	genhtml -q -o coverage coverage/lcov.info && open coverage/index.html


# CODE GENERATION

l10n :
	flutter gen-l10n && arb_utils sort lib/l10n/app_en.arb 

asset-gen :
	fluttergen

gen :
	dart run build_runner build --delete-conflicting-outputs || make try-fix-gen
