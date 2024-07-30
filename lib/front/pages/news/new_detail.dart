import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/back/api/api_news.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';

class NewsDetailPage extends StatelessWidget {
  final Data newsItem;

  NewsDetailPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Yangiliklar'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      newsItem.img!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    newsItem.title ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    newsItem.content ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        newsItem.createdAt ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.visibility, size: 16, color: Colors.red),
                          SizedBox(width: 5),
                          Text(
                            newsItem.views ?? '0',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
