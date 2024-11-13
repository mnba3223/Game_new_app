part of 'news_detail_bloc.dart';

@freezed
class NewsDetailState with _$NewsDetailState {
  const factory NewsDetailState.initial() = _Initial;
  const factory NewsDetailState.loading() = _Loading;
  const factory NewsDetailState.loaded(News news) = _Loaded;
  const factory NewsDetailState.error(String message) = _Error;
}
