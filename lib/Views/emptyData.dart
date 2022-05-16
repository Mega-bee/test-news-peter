import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  final String image;
  final String message;
  EmptyData({required this.image,required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(message)
          ],
        ),
      ),
    );
  }
}