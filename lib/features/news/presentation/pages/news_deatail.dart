// lib/features/news/presentation/pages/news_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_news/features/news/data/repositories/news_repository.dart';
import 'package:game_news/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsId;

  const NewsDetailPage({
    super.key,
    required this.newsId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsDetailBloc(
        context.read<NewsRepository>(),
      )..add(NewsDetailEvent.loadRequested(newsId)),
      child: Scaffold(
        body: BlocBuilder<NewsDetailBloc, NewsDetailState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (news) => CustomScrollView(
                slivers: [
                  // 可滾動的 AppBar
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        news.title,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      background: Image.network(
                        news.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // 內容
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 時間和分類
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatDate(news.createdAt),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              if (news.category != null) ...[
                                const SizedBox(width: 16),
                                Chip(
                                  label: Text(news.category!),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 16),

                          // 內文
                          Text(
                            news.content,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }
}
