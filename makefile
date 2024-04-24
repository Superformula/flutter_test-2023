PACKAGES := $(wildcard packages/*)
FEATURES := $(wildcard packages/features/*)

get:
	fvm flutter pub get
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Updating dependencies on $${feature}" ; \
		fvm flutter pub get ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Updating dependencies on $${package}" ; \
		fvm flutter pub get ; \
		cd ../../ ; \
	done

clean:
	fvm flutter clean
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Running clean on $${feature}" ; \
		fvm flutter clean ; \
		cd ../../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Running clean on $${package}" ; \
		fvm flutter clean ; \
		cd ../../ ; \
	done

build-runner:
	for package in $(BUILD-RUNNER); do \
		cd $${package} ; \
		echo "Running build-runner on $${package}" ; \
		fvm flutter pub run build_runner build --delete-conflicting-outputs ; \
		cd ../../ ; \
	done