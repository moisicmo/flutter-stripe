# Flutter + Stripe

PROYECTO SOLO DE DEMOSTRACIÓN EN INTEGRACIÓN STRIPE CON FLUTTER

## Installation

```sh
dart pub add flutter_stripe
```

### Requirements

#### Android

This plugin requires several changes to be able to work on Android devices. Please make sure you follow all these steps:

1. Use Android 5.0 (API level 21) and above
2. Use Kotlin version 1.5.0 and above: [example](https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/build.gradle)
3. Requires Android Gradle plugin 8 and higher
4. Using a descendant of `Theme.AppCompat` for your activity: [example](https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/app/src/main/res/values/styles.xml#L15), [example night theme](https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/app/src/main/res/values-night/styles.xml#L16)
5. Using an up-to-date Android gradle build tools version: [example](https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/build.gradle#L9) and an up-to-date gradle version accordingly: [example](https://github.com/flutter-stripe/flutter_stripe/blob/main/example/android/gradle/wrapper/gradle-wrapper.properties#L6)
6. Using `FlutterFragmentActivity` instead of `FlutterActivity` in `MainActivity.kt`: [example](https://github.com/flutter-stripe/flutter_stripe/blob/79b201a2e9b827196d6a97bb41e1d0e526632a5a/example/android/app/src/main/kotlin/com/flutter/stripe/example/MainActivity.kt#L6)
7. Add the following rules to your `proguard-rules.pro` file: [example](https://github.com/flutter-stripe/flutter_stripe/blob/master/example/android/app/proguard-rules.pro)

```proguard
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
```

8. Rebuild the app, as the above changes don't update with hot reload

These changes are needed because the Android Stripe SDK requires the use of the AppCompat theme for their UI components and the Support Fragment Manager for the Payment Sheets

If you are having troubles to make this package to work on Android, join [this discussion](https://github.com/flutter-stripe/flutter_stripe/discussions/538) to get some support.

#### iOS

Compatible with apps targeting iOS 13 or above.

To upgrade your iOS deployment target to 13.0, you can either do so in Xcode under your Build Settings, or by modifying IPHONEOS_DEPLOYMENT_TARGET in your project.pbxproj directly.

You will also need to update in your Podfile:

`platform :ios, '13.0'`

For card scanning add the following to your Info.plist:

```xml
<key>NSCameraUsageDescription</key>
<string>Scan your card to add it automatically</string>
<key>NSCameraUsageDescription
&lt;string&gt;To scan cards&lt;/string&gt;</key>
<string>To scan cards</string>
```

## EVIROMENT

crear un archivo .env con las dos llaves PUBLISHER_KEY y STRIPE_SECRET

## DESCRIPCIÖN

paso 1

- se debe ejecutar con la llave PUBLISHER_KEY

```sh
  await Stripe.instance.applySettings();
```

paso 2

- se debe ejecutar con la llave STRIPE_SECRET

```sh
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          primaryButtonLabel: 'Pagar ahora',
          merchantDisplayName: 'Flutter Stripe Store Demo',
          billingDetails: const BillingDetails(
            name: 'YOUR NAME',
            email: 'YOUREMAIL@gmail.com',
            phone: 'YOUR NUMBER',
            address: Address(
              city: 'YOUR CITY',
              country: 'YOUR COUNTRY',
              line1: 'YOUR ADDRESS 1',
              line2: 'YOUR ADDRESS 2',
              postalCode: 'YOUR PINCODE',
              state: 'YOUR STATE',
            ),
          ),
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          // merchantDisplayName: 'Ikay',
        ),
      );
```

esto hace la configuración del pago

paso 3

- ejecutar:

```sh
  await Stripe.instance.presentPaymentSheet();
```

esto abrira con el sdk una pantalla paracolocar los datos de la tarjeta
al finalizar este respondera si se pago o no
