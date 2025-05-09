part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

final class FetchNews extends NewsEvent {

}
