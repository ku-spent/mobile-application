APP_NAME = SPENT

beta-android:
	flutter clean && flutter pub get && flutter build apk --release --bundle-sksl-path flutter_02.sksl.json && cd android && fastlane android_beta_app

beta-ios:
	echo "beta ios"

gen-model:
	amplify codegen models && mv lib/models/* lib/domain/model/