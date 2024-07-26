import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/back/api/api_news.dart';
import 'package:qoriqlash_xizmati/front/components/appbar_title.dart';
import 'package:qoriqlash_xizmati/front/components/progress_for_news.dart';
import 'package:qoriqlash_xizmati/front/pages/news/new_detail.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<News> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = News.fetchNews(10, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          const AppbarTitle(),
          Expanded(
            child: FutureBuilder<News>(
              future: futureNews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      var newsItem = snapshot.data!.data![index];
                      return NewsCard(newsItem: newsItem);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }

                return Column(
                  children: [
                    ProgressForNews(),
                    ProgressForNews(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class NewsCard extends StatelessWidget {
  final Data newsItem;

  NewsCard({required this.newsItem});

  String truncateContent(String content, int length) {
    return (content.length > length)
        ? '${content.substring(0, length)}...'
        : content;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              newsItem.img!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsItem.title ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  truncateContent(newsItem.content ?? '', 100),
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
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
                        Icon(Icons.visibility, size: 16, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          newsItem.views ?? '0',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailPage(newsItem: newsItem),
                        ),
                      );
                    },
                    child: Text(
                      'Batafsil',
                      style: AppStyle.fontStyle
                          .copyWith(color: AppColors.lightHeaderColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CaruseItem extends StatefulWidget {
//   const CaruseItem({
//     super.key,
//   });

//   @override
//   State<CaruseItem> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<CaruseItem> {
//   List<CarouselItem> itemList = [
//     CarouselItem(
//       image: const NetworkImage(
//         'https://miro.medium.com/max/1400/1*RpaR1pTpRa0PUdNdfv4njA.png',
//       ),
//       boxDecoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: FractionalOffset.bottomCenter,
//           end: FractionalOffset.topCenter,
//           colors: [
//             Colors.blueAccent.withOpacity(1),
//             Colors.black.withOpacity(.3),
//           ],
//           stops: const [0.0, 1.0],
//         ),
//       ),
//       title:
//           'Push your creativity to its limits by reimagining this classic puzzle!',
//       titleTextStyle: const TextStyle(
//         fontSize: 12,
//         color: Colors.white,
//       ),
//       leftSubtitle: '\$51,046 in prizes',
//       rightSubtitle: '4882 participants',
//       rightSubtitleTextStyle: const TextStyle(
//         fontSize: 12,
//         color: Colors.black,
//       ),
//       onImageTap: (i) {
//         print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa$i');
//       },
//     ),
//     CarouselItem(
//       image: const NetworkImage(
//         'https://pbs.twimg.com/profile_banners/1444928438331224069/1633448972/600x200',
//       ),
//       title: '@coskuncay published flutter_custom_carousel_slider!',
//       titleTextStyle: const TextStyle(
//         fontSize: 12,
//         color: Colors.white,
//       ),
//       leftSubtitle: '11 Feb 2022',
//       rightSubtitle: 'v1.0.0',
//       onImageTap: (i) {
//         print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa$i');
//       },
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 CustomCarouselSlider(
//                   items: itemList,
//                   height: 150,
//                   subHeight: 50,
//                   width: MediaQuery.of(context).size.width * .9,
//                   autoplay: true,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
