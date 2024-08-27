import '../data_models/news.dart';

class NewsResponse {
  List<News> ?articles;

  NewsResponse({required this.articles});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    if(json['articles']!=null){
          articles=[];
       json['articles'].forEach((v){
           articles?.add(News.fromJson(v));
       });
    }

  }
}
