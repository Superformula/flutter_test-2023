# TESTS:

all-tests : tests integration-tests

tests : 
	flutter test --coverage

integration-tests : 
	flutter test integration_test/app_test.dart

lcov-ignore : 
	lcov --remove coverage/lcov.info 'lib/core/*' 'lib/theme/*' 'lib/models/*.g.dart' -o coverage/lcov.info

show-coverage : tests lcov


lcov : tests lcov-ignore
	genhtml -q -o coverage coverage/lcov.info && open coverage/index.html

update-goldens : remove-goldens-failures
	flutter test --update-goldens

remove-goldens-failures : 
	rm test/golden_test/failures/*

# CODE GENERATION

l10n :
	flutter gen-l10n && arb_utils sort lib/l10n/app_en.arb 

gen :
	flutter packages pub run build_runner build --delete-conflicting-outputs

get :
	flutter pub get