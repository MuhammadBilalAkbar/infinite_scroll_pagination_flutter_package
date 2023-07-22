import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/model/post_model.dart';
import '/widgets/post_widget.dart';

class InfiniteScrollPaginationPage extends StatefulWidget {
  const InfiniteScrollPaginationPage({super.key});

  @override
  InfiniteScrollPaginationPageState createState() =>
      InfiniteScrollPaginationPageState();
}

class InfiniteScrollPaginationPageState
    extends State<InfiniteScrollPaginationPage> {
  static const numberOfPostsPerRequest = 20;

  final PagingController<int, PostModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final response = await get(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$numberOfPostsPerRequest'),
      );
      List responseList = json.decode(response.body);
      final postList = responseList
          .map((data) => PostModel(
                id: data['id'],
                title: data['title'],
                body: data['body'],
              ))
          .toList();
      final isLastPage = postList.length < numberOfPostsPerRequest;
      if (isLastPage) {
        pagingController.appendLastPage(postList);
        debugPrint('All pages ended. This is the last page');
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(postList, nextPageKey);
      }
    } catch (error) {
      debugPrint('error --> $error');
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Infinite Scroll Pagination Package'),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: PagedListView<int, PostModel>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<PostModel>(
              animateTransitions: true,
              itemBuilder: (context, item, index) {
                if (index == pagingController.itemList!.length - 1) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Center(child: Text('No more data')),
                  );
                } else {
                  return PostWidget(
                    id: item.id,
                    title: item.title,
                    body: item.body,
                  );
                }
              },
            ),
          ),
        ),
      );
}
