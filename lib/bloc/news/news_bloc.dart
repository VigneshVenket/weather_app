
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/repository/news_repo.dart';
import 'news_event.dart';
import 'news_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepo newsRepo;

  NewsBloc({required this.newsRepo}) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield NewsLoading();
      try {
        final newsResponse = await newsRepo.fetchNews();
        yield NewsLoaded(newsResponse.articles!);
      } catch (e) {
        print(e.toString());
        yield NewsError(e.toString());
      }
    }
  }
}
