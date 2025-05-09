import 'package:fin_hub/features/news/data/models/news_model.dart';
import 'package:fin_hub/features/news/data/repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNews>(_fetchNews);
  }

  void _fetchNews(FetchNews even, Emitter<NewsState> emit) async {
    emit(FetchNewsLoading());
    try {
      final news = await newsRepository.fetchNews();
      emit(FetchNewsSuccess(news: news));

    }catch (e) {
      emit(FetchNewsError(message: e.toString()));
    }
  }
}
