import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stella/ui/home.dart';
import 'package:stella/ui/neumorph.dart';

void main() {
  runApp(StellaApp());
}

class AppBuilder extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NeuButton(
              child: Container(
                width: 250,
                height: 250,
              ),
              shape: NeuShape.Pressed,
            ),
          ],
        ),
      ),
      backgroundColor: StellaTheme.of(context).backgroundColor,
    );
  }
}

class MainAppWrapper extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MediaQuery(  // lock font scale
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: StellaTheme(  // set stella theme
        child: HomeRoute(),
        lightTheme: null,
        darkTheme: null,
      ),
    );
  }
}

class StellaApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
        Locale.fromSubtags(languageCode: 'en'),
        Locale.fromSubtags(languageCode: 'jp'),
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // enforce flutter using device locale
        return deviceLocale;
      },
      title: 'Stella',
      home: MainAppWrapper(),
    );
  }
}
