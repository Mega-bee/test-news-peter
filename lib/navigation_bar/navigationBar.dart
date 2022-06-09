import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../helpers/colors.dart';
import '../hive/hive.dart';
import '../instgram_module/ui/screen/instagram.dart';
import '../news_by_date/ui/screen/news_by_date.dart';
import '../news_module/ui/screen/news-list-1.dart';
import '../settings_module/settings.dart';
import '../weather_module/ui/screens/weather_screen.dart';

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;
  final screens = [
    NewsListOne(),
    WeatherScreen(),
    NewsByDate(),
    Instagram(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 500),
        color: ThemeHelper().getisDark() ?  lighterblackColor : cardColor,
        buttonBackgroundColor:
            ThemeHelper().getisDark() ? blackColor : textColor,
        backgroundColor: Colors.transparent,
        height: 60,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: ThemeHelper().getisDark() ? textColor : blackColor ,
          ),
          Icon(
            Icons.cloud,
            color: ThemeHelper().getisDark() ? textColor : blackColor,
          ),
          Icon(
            Icons.newspaper,
            color: ThemeHelper().getisDark() ? textColor : blackColor,

          ),
          Icon(
              FontAwesomeIcons.instagram,
            color: ThemeHelper().getisDark() ? textColor : blackColor,
          ),
          Icon(
            Icons.settings,
            color: ThemeHelper().getisDark() ? textColor : blackColor,
          ),

        ],
      ),
    );
  }
}


