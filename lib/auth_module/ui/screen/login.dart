import 'package:flutter/material.dart';
import 'package:news_app/Helpers/colors.dart';

import '../widget/TextFormField.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: customColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: mediaQueryHeight * 0.35,
                width: mediaQueryWidth,
                child: Stack(children: [
                  Container(
                    height: mediaQueryHeight * 0.62,
                    child: Column(

                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: MediaQuery.of(context).size.height * 0.3,
                            color: textColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              TextFormFieldWidget()
            ],
          ),
        ),
      ),
    );
  }
}
