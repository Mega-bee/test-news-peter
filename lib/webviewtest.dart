import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: 300,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("test"),
                );
              },
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: 'https://stackoverflow.com',
            ),
          ),
        ],
      ),
    );
  }
}
