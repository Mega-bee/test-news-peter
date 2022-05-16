import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsOne.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  final NewsOne newsone;

  NewsCard(this.newsone);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(
                    newsone.urlToImage.toString(),
                  ),
                  height: 240,
                  fit: BoxFit.cover,
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
              child: Expanded(
                child: Text(
                  "${newsone.url ?? "No url"}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 14),
              child: Expanded(
                child: Text(
                  "-${timeago.format(DateTime.parse(newsone.publishedAt.toString()))}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
