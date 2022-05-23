import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news_module/model/NewsOne.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../news_details_module/ui/screen/news_details.dart';

class NewsCard extends StatelessWidget {
  final NewsOne newsone;

  NewsCard(this.newsone);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetails(
              image: newsone.urlToImage,
              title: newsone.title,
              date: newsone.publishedAt,
              author: newsone.author,
              url: newsone.url,
              description: newsone.description,
            ),
          ),
        );
      },
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: newsone.urlToImage.toString(),
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Text(
                      '${newsone.author ?? "No author"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            "${DateFormat.yMMMMEEEEd().format(DateTime.parse(newsone.publishedAt.toString()))}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Text(
                  "${newsone.title ?? "no title"}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Text(
                  "${newsone.description ?? "no description"}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 14),
                child: Text(
                  "${newsone.url ?? "No url"}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 14),
                child: Text(
                  "-${timeago.format(DateTime.parse(newsone.publishedAt.toString()))}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
