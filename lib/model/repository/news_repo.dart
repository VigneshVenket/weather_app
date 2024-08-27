

import '../api/api_provider.dart';
import '../response/news_response.dart';

class NewsRepo{

  ApiProvider apiProvider=ApiProvider();

  Future<NewsResponse>  fetchNews(){
    return apiProvider.fetchNews();
  }
}