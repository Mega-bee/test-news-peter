import 'package:flutter/material.dart';

class ConnectionErrorScreen extends StatelessWidget {
  final String errorMessage;
  final Function retry;
  ConnectionErrorScreen({required this.retry, required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset("assets/images/wifi.png"),
            Text("Error"),
           const SizedBox(
              height: 15,
            ),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.black),
            ),
            const   SizedBox(
              height: 30,
            ),
            RaisedButton(
                onPressed: () {
                  retry();
                },
                child:const Text(
                 'Retry',
                  style: TextStyle(color: Colors.black),
                ),
                // color: AppColors.greenBasic,
                elevation: 5.0,
                shape:const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))))
          ],
        ),
      ),
    ));
  }
}
