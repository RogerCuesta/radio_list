# flutter_radio_list

Flutter app that use Radio Browser API to show list of Radio and have a Radio Player for listen it.

## Concepts used

* Clean Architecture 🏗️
* Modularity
* BloC
* localizations
* Custom Theme

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:coffee_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```


## Screenshots

![Simulator Screenshot - iPhone 14 Pro Max - 2023-07-18 at 10 06 17](https://github.com/RogerCuesta/radio_list/assets/25230461/b38880c4-23a8-41d3-8d09-8021702ebdfc)

![Simulator Screenshot - iPhone 14 Pro Max - 2023-07-18 at 10 07 35](https://github.com/RogerCuesta/radio_list/assets/25230461/518f22ce-097d-4743-9f58-2d3426d0806b)

![Simulator Screenshot - iPhone 14 Pro Max - 2023-07-18 at 10 07 45](https://github.com/RogerCuesta/radio_list/assets/25230461/a24c0273-3a3b-4e1e-ae66-edeaae8e20f0)
