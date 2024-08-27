
import '../../model/data_models/news.dart';

abstract class NewsState{
  const NewsState();

}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;

  const NewsLoaded(this.news);

}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);
}
