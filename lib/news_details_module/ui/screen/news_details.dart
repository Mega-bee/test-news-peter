import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Helpers/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:webview_flutter/webview_flutter.dart';

import 'webview.dart';

class NewsDetails extends StatefulWidget {
  final String? title;
  final String? image;
  final String? date;
  final String? author;
  final String? url;
  final String? description;

  NewsDetails(
      {this.title,
      this.image,
      this.date,
      this.author,
      this.url,
      this.description});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late WebViewController controller;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.author}"),
        centerTitle: true,
      ),
      body: Container(
        color: customColor,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      color: textColor,
                    ),
                  ),
                  width: double.infinity,
                  imageUrl: widget.image.toString(),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: customColor,
                      border: Border.all(color: textColor),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: textColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          "${DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.date.toString()))}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: IconButton(
                    onPressed: () async {
                      await Share.share("By News App: \n ${widget.url}");
                    },
                    icon: Icon(Icons.share),
                    iconSize: 20,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
              child: Text(
                "${widget.title ?? "no title"}",
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                  child: Text(
                    "${widget.author ?? "no author"}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                  child: Text(
                    "${timeago.format(DateTime.parse(widget.date.toString()))}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebVieww(url: widget.url),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Text(
                  "${widget.url}",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              // thickness of the line
              indent: 20,
              // empty space to the leading edge of divider.
              endIndent: 20,
              // empty space to the trailing edge of the divider.
              color: textColor,
              // The color to use when painting the line.
              height: 20,
            ),

            // ConstrainedBox(
            //   constraints: BoxConstraints(maxHeight: 10000),
            //   child: WebView(
            //     javascriptMode: JavascriptMode.unrestricted,
            //     initialUrl: widget.url,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
