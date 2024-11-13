import 'package:dio/dio.dart';
import '../models/news.dart';

class NewsRepository {
  final Dio _dio;

  NewsRepository({required Dio dio}) : _dio = dio;

  Future<List<News>> getNewsList() async {
    try {
      final response = await _dio.get('/news');

      // 确保response.data是List类型
      if (response.data is! List) {
        throw Exception('Invalid response format');
      }

      // 明确类型转换和错误处理
      return (response.data as List).map((item) {
        if (item is! Map<String, dynamic>) {
          throw Exception('Invalid item format');
        }

        // 处理可能的编码问题
        final sanitizedItem = Map<String, dynamic>.from(item).map(
          (key, value) => MapEntry(
            key,
            value is String ? _sanitizeString(value) : value,
          ),
        );

        try {
          return News.fromJson(sanitizedItem);
        } catch (e) {
          print('Error parsing item: $sanitizedItem');
          print('Parse error: $e');
          rethrow;
        }
      }).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('获取新闻列表失败: $e');
    }
  }

  Future<News> getNewsDetail(String id) async {
    try {
      final response = await _dio.get('/news/$id');

      if (response.data is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      final sanitizedData = Map<String, dynamic>.from(response.data).map(
        (key, value) => MapEntry(
          key,
          value is String ? _sanitizeString(value) : value,
        ),
      );

      return News.fromJson(sanitizedData);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('获取新闻详情失败: $e');
    }
  }

  String _sanitizeString(String input) {
    // 处理可能的特殊字符
    return input
        .replaceAll('\u0000', '') // 移除 null 字符
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), ''); // 移除控制字符
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('连接超时');
      case DioExceptionType.connectionError:
        return Exception('网络连接失败');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return Exception('未授权');
        } else if (statusCode == 404) {
          return Exception('资源不存在');
        }
        return Exception('服务器错误: $statusCode');
      default:
        return Exception('网络错误: ${error.message}');
    }
  }
}
