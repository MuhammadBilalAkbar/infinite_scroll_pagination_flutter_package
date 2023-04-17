import 'package:flutter/material.dart';

import 'pages/infinite_scroll_pagination_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Infinite Scroll Pagination Package',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        home: const InfiniteScrollPaginationPage(),
      );
}
