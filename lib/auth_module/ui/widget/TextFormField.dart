import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:news_app/Helpers/colors.dart';
import '../../../generated/l10n.dart';
import '../../../hive/hive.dart';
import '../../../navigation_bar/navigationBar.dart';
import '../../../network/WebUrl.dart';
import '../../../news_module/ui/screen/news-list-1.dart';

class TextFormFieldWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final apiKey = TextEditingController(text:"a1a15821dc0e4d7cb89bd20d3f1e2202");


  String validatePass(value) {
    if (value.isEmpty) {
      return 'Required *';
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQueryWidth * 0.05),
            child: TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: apiKey,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.key),
                filled: true,
                fillColor: Colors.white,
                hintText: S.of(context).ApiKey,
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2, color: Colors.black12)),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: S.of(context).Required),
                // EmailValidator(errorText: 'Not a valid Key'),
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // keyboardType: TextInputType.
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          ElevatedButton(
            onPressed: () {
              if (apiKey.text.isEmpty) {
                _formKey.currentState!.validate();
              }
              else if (apiKey.text != Urls.apiToken) {
                Fluttertoast.showToast(msg: S.of(context).InvalidKey);
              }
              else {
                {

                  AuthPrefsHelper().setToken(Urls.apiToken);



                  AuthPrefsHelper().setToken(Urls.apiToken);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Navigation()),
                  );
                }
              }
            },
            child:  Text(
              S.of(context).LogIn,
              style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto-Bold'),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQueryWidth * 0.35,
                  vertical: mediaQueryHeight * 0.025),
              primary: customColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),

              ),
              side: BorderSide(
                width: 2.0,
                color:textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
