import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_news/features/news/data/models/news.dart';
import 'package:game_news/features/news/data/repositories/news_repository.dart';

part 'news_detail_event.dart';
part 'news_detail_state.dart';
part 'news_detail_bloc.freezed.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final NewsRepository _newsRepository;

  NewsDetailBloc(this._newsRepository)
      : super(const NewsDetailState.initial()) {
    on<NewsDetailLoadRequested>((event, emit) async {
      emit(const NewsDetailState.loading());
      try {
        final news = await _newsRepository.getNewsDetail(event.id);
        emit(NewsDetailState.loaded(news));
      } catch (e) {
        emit(NewsDetailState.error(e.toString()));
      }
    });
  }
}
