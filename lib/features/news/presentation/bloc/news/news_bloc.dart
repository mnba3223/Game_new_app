import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_news/features/news/data/models/news.dart';
import 'package:game_news/features/news/data/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';
part 'news_bloc.freezed.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(const NewsState.initial()) {
    on<NewsLoadRequested>((event, emit) async {
      emit(const NewsState.loading());
      try {
        final news = await _newsRepository.getNewsList();
        emit(NewsState.loaded(news));
      } catch (e) {
        emit(NewsState.error(e.toString()));
      }
    });
  }
}
