import 'dart:convert';
import 'package:http/http.dart' as http;

class News {
  List<Data>? data;
  String? total;

  News({this.data, this.total});

  News.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }

  static Future<News> fetchNews(int limit, int offset) async {
    final response = await http.get(
        Uri.parse('https://qbb.uz/v1/api/news?limit=$limit&offset=$offset'));

    if (response.statusCode == 200) {
      return News.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class Data {
  String? id;
  String? title;
  String? content;
  String? shortContent;
  String? img;
  String? views;
  String? alias;
  String? statusNew;
  String? status;
  String? createdAt;

  Data(
      {this.id,
      this.title,
      this.content,
      this.shortContent,
      this.img,
      this.views,
      this.alias,
      this.statusNew,
      this.status,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    shortContent = json['short_content'];
    img = json['img'];
    views = json['views'];
    alias = json['alias'];
    statusNew = json['status_new'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['short_content'] = this.shortContent;
    data['img'] = this.img;
    data['views'] = this.views;
    data['alias'] = this.alias;
    data['status_new'] = this.statusNew;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
