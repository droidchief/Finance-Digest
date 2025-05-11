import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../features/news/data/models/news_model.dart';
import '../features/news/data/repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNews>(_fetchNews);
  }

  void _fetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(FetchNewsLoading());
    try {
      debugPrint("Fetch news");
      final news = await newsRepository.fetchNews();
      emit(FetchNewsSuccess(news: news));

    }catch (e) {
      emit(FetchNewsError(message: e.toString()));
      debugPrint("Fetch news error ${e.toString()}");
    }
  }

  @override
  void onChange(Change<NewsState> change) {
    debugPrint("News bloc change $change");
    super.onChange(change);
  }
}
