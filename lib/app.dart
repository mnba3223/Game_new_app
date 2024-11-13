import 'package:flutter/material.dart';
import 'config/router.dart';

class GameNewsApp extends StatelessWidget {
  const GameNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Game News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router, // GoRouter 配置
    );
  }
}