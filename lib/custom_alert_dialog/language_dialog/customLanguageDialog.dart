import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../helpers/colors.dart';
import '../../hive/hive.dart';
import '../../service/localization_service/localization_serrvice.dart';

class CustomLanguageDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function arabicBtn;
  final Function() englishBtn;

  CustomLanguageDialog(
      {required this.title,
      required this.content,
      required this.arabicBtn,
      required this.englishBtn});

  @override
  State<CustomLanguageDialog> createState() => _CustomLanguageDialog();
}

class _CustomLanguageDialog extends State<CustomLanguageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeHelper().getisDark() ? blackColor : customColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        widget.title,
        style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "BerlinSansFB"),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.content,
            style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontFamily: "BerlinSansFB",
            ),
            textAlign: TextAlign.center,
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    LocalizationService().setLanguage('en');
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).English,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BerlinSansFB",
                        color: textColor),
                  )),
              TextButton(
                onPressed: () {
                  LocalizationService().setLanguage('ar');
                  Navigator.pop(context);
                },
                child: Text(S.of(context).Arabic,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "BerlinSansFB",
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
