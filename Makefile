tests : 
	flutter test

update-goldens : 
	flutter test --update-goldens

l10n :
	flutter gen-l10n && arb_utils sort lib/l10n/app_en.arb 

gen :
	flutter packages pub run build_runner build --delete-conflicting-outputs

get :
	flutter pub get