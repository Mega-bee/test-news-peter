import 'package:flutter/material.dart';

import '../Auth_Module/ui/screen/login.dart';
import '../custom_alert_dialog/language_dialog/customLanguageDialog.dart';
import '../custom_alert_dialog/logout_dialog/customLogOutDialog.dart';
import '../custom_alert_dialog/theme_dialog/customThemeDialog.dart';
import '../generated/l10n.dart';
import '../helpers/colors.dart';
import '../hive/hive.dart';
import '../service/localization_service/localization_serrvice.dart';
import '../service/theme_serrvice/theme_service.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Settings,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomLanguageDialog(
                  title: S.of(context).Language,
                  content: "",
                  englishBtn: () {
                    LocalizationService().setLanguage('en');
                  },
                  arabicBtn: () {
                    LocalizationService().setLanguage('ar');
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Card(
                elevation: 5,
                color: ThemeHelper().getisDark() ? blackColor : textColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Language,
                      ),
                      Icon(Icons.language),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => CustomThemeDialog(
                      title: S.of(context).Language,
                      content: "",
                      darkBtn: () {
                        AppThemeDataService().switchDarkMode(true);
                        Navigator.pop(context);
                        setState(() {

                        });
                      },
                      lightBtn: () {
                        AppThemeDataService().switchDarkMode(false);
                        Navigator.pop(context);
                        setState(() {

                        });
                      }));
            },
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Card(
                elevation: 5,
                color: ThemeHelper().getisDark() ? blackColor : textColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Theme,
                      ),
                      Icon(Icons.color_lens_outlined),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomLogOutDialog(
                  title: S.of(context).LogOut,
                  content: "",
                  yesBtn: () {
                    AuthPrefsHelper().clearToken().then((value) =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false));
                  },
                  noBtn: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Card(
                elevation: 5,
                color: ThemeHelper().getisDark() ? blackColor : textColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).LogOut,
                      ),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
