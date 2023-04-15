import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'model/post.dart';
import 'widgets/post_item.dart';

class InfiniteScrollPaginator extends StatefulWidget {
  const InfiniteScrollPaginator({super.key});

  @override
  InfiniteScrollPaginatorState createState() => InfiniteScrollPaginatorState();
}

class InfiniteScrollPaginatorState extends State<InfiniteScrollPaginator> {
  static const numberOfPostsPerRequest = 10;

  final PagingController<int, Post> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final response = await get(
        Uri.parse(
            "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$numberOfPostsPerRequest"),
      );
      List responseList = json.decode(response.body);
      // debugPrint(responseList.toString());
      List<Post> postList = responseList
          .map((data) => Post(
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
    } catch (e) {
      debugPrint("error --> $e");
      pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Infinite Scroll Pagination Package"),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: PagedListView<int, Post>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<Post>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  if (index == pagingController.itemList!.length - 1) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Center(child: Text('No more data')),
                    );
                  }
                  return PostItem(
                    id: item.id,
                    title: item.title,
                    body: item.body,
                  );
                }),
          ),
        ),
      );
}
