import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_news/features/news/data/repositories/news_repository.dart';
import 'package:game_news/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:game_news/features/news/presentation/pages/news_card.dart';


class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        context.read<NewsRepository>(),
      )..add(const NewsEvent.loadRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Game News')),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (news) => ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) => NewsCard(
                  news: news[index],
                ),
              ),
              error: (message) => Center(
                child: Text('Error: $message'),
              ),
            );
          },
        ),
      ),
    );
  }
}