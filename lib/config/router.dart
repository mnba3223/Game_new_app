import 'package:go_router/go_router.dart';
import '../features/news/presentation/pages/news_page.dart';
import '../features/news/presentation/pages/news_detail_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NewsPage(),
    ),
    GoRoute(
      path: '/news/:id',
      builder: (context, state) => NewsDetailPage(
        newsId: state.pathParameters['id']!,
      ),
    ),
  ],
);