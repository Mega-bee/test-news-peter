import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVieww extends StatefulWidget {
  final String? url;

  WebVieww({this.url});

  @override
  State<WebVieww> createState() => _WebViewwState();
}

class _WebViewwState extends State<WebVieww> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
        onWebViewCreated: (controller){
          this.controller = controller;
        },
      ),
    );
  }
}
