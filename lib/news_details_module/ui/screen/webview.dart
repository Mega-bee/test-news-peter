import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../helpers/colors.dart';
import '../../../hive/hive.dart';

class WebVieww extends StatefulWidget {
  final String? url;

  WebVieww({required this.url});

  @override
  State<WebVieww> createState() => _WebViewwState();
}

class _WebViewwState extends State<WebVieww> {
  late WebViewController controller;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();

          ///stay in app
          return false;
        } else {
          ///leave app
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Webview"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              controller.clearCache();
              CookieManager().clearCookies();
            },
            icon: Icon(
              Icons.clear,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                }
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
            IconButton(
              onPressed: () => controller.reload(),
              icon: Icon(
                Icons.refresh_sharp,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: ThemeHelper().getisDark() ? lightColor : textColor,
              backgroundColor: Colors.black,
            ),
            Expanded(
              child: WebView(
                backgroundColor:
                    ThemeHelper().getisDark() ? lightColor : textColor,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onProgress: (progress) => setState(() {
                  this.progress = progress / 100;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
