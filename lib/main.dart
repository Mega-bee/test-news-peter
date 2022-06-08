import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/service/localization_service/localization_serrvice.dart';
import 'package:news_app/service/theme_serrvice/theme_service.dart';
import 'package:news_app/splash_Screen/ui/screens/splash_screen.dart';
import 'generated/l10n.dart';
import 'hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetUp.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LocalizationService _localizationService;
  late AppThemeDataService _appThemeDataService;
  late String lang ;
  late ThemeData activeThem;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        ///language
        // onGenerateTitle: (BuildContext context) => S.of(context).filterByDate,
        title: 'News app',
        theme: activeThem,
        ///language
        locale: Locale.fromSubtags(
          languageCode: lang,
        ),
        ///language
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        ///language
        supportedLocales: S.delegate.supportedLocales,
        home: SplashScreen());
  }
  ///language
  @override
  void initState() {
    _localizationService = LocalizationService();
    _appThemeDataService = AppThemeDataService();
    lang = _localizationService.getLanguage();
    activeThem =_appThemeDataService.getActiveTheme();

    _localizationService.localizationStream.listen((event) {
      lang = event;
      setState(() {});
    });

    _appThemeDataService.darkModeStream.listen((event) {
      activeThem = event;
      setState(() {

      });
    });
  }


}
