part of 'news_detail_bloc.dart';

@freezed
class NewsDetailEvent with _$NewsDetailEvent {
  const factory NewsDetailEvent.loadRequested(String id) =
      NewsDetailLoadRequested;
}
