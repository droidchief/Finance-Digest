part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class FetchNewsLoading extends NewsState {}

final class FetchNewsError extends NewsState {
  final String message;
  FetchNewsError({required this.message});
}

final class FetchNewsSuccess extends NewsState {
  final List<NewsModel>? news;

  FetchNewsSuccess({this.news});
}
