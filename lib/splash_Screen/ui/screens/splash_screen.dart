import 'dart:async';

import 'package:flutter/material.dart';

import '../../../Auth_Module/ui/screen/login.dart';
import '../../../hive/hive.dart';
import '../../../news_module/ui/screen/news-list-1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 7),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        "assets/images/logo.png",
        height: MediaQuery.of(context).size.height * 3,
        width: MediaQuery.of(context).size.width * 2,
      )),
    );
  }

  Future<bool> getNextPage() {
//    Future.delayed(Duration(seconds: 6));
    String? token = AuthPrefsHelper().getToken();
    if (token != null) {
      return Future.value(true);
    } else
      return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (1)),
      vsync: this,
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getNextPage().then((value) => {
            if (value)
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => NewsListOne()),
                  (route) => false)
            else
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false)
              }
          });
    });
  }
}
