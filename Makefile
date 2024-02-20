# TESTS:

all-tests : tests integration-tests

tests : 
	flutter test --coverage

integration-tests : 
	flutter test integration_test/app_test.dart

lcov : 
	genhtml -q -o coverage coverage/lcov.info && open coverage/index.html

update-goldens : 
	flutter test --update-goldens

# CODE GENERATION

l10n :
	flutter gen-l10n && arb_utils sort lib/l10n/app_en.arb 

gen :
	flutter packages pub run build_runner build --delete-conflicting-outputs

get :
	flutter pub get