import 'package:flutter/material.dart';

import 'infinite_scroll_paginator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Scroll Pagination Package',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: const InfiniteScrollPaginator(),
    );
  }
}