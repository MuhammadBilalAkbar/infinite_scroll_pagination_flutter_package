## 1. Research: Infinite Scroll Pagination Flutter Package

- Keywords:
    - infinite scroll pagination flutter package
    - flutter infinite scroll pagination example
    - infinite scroll listview flutter
    - infinite pagination flutter
    - flutter infinite scroll api
    - flutter pagination on scroll
    - listview pagination flutter
    - sliverlist pagination flutter
    - flutter pagination on scroll
    - flutter pagination listview
    - flutter infinite_scroll_pagination
    - flutter pagination example
    - flutter infinite scroll listview
    - flutter listview load more on scroll
    - sliverlist pagination flutter
    - how to implement pagination in flutter

- Video Title: Infinite Scroll Pagination Package in Flutter - How to infinite scroll/paginate
  ListView, SliverList or SliverGrid

## 2. Research: Competitors

**Flutter Videos/Articles**

- 2.1K: https://youtu.be/brZW149xmtA
- https://pub.dev/packages/infinite_scroll_pagination
- https://pub.dev/documentation/infinite_scroll_pagination/latest/
- https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/
- https://medium.com/solute-labs/paginate-your-data-in-flutter-7744995febd1
- https://www.kodeco.com/14214369-infinite-scrolling-pagination-in-flutter

**Android/Swift/React Videos**

- 11K: https://www.youtube.com/watch?v=nJovARMajeE
- 90K: https://www.youtube.com/watch?v=2-vZ1g_G1Zo
- 4.1K: https://www.youtube.com/watch?v=7Lff-QClhsY
- 4.1K: https://www.youtube.com/watch?v=z0Ospm5m-HY
- 33K: https://www.youtube.com/watch?v=TxH35Iqw89A
- 2.6K: https://www.youtube.com/watch?v=8T8W_hAL9wE
- 17K: https://www.youtube.com/watch?v=jow2lXber3A
- 6.8K: https://www.youtube.com/watch?v=JIZg6Ax-HFc
- https://proandroiddev.com/infinite-scrolling-with-android-paging-library-and-flow-api-e017f47517d6
- https://guides.codepath.com/android/endless-scrolling-with-adapterviews-and-recyclerview
- https://guides.codepath.com/android/endless-scrolling-with-adapterviews-and-recyclerview
- https://levelup.gitconnected.com/how-to-create-infinite-scroll-in-uitableview-b021732922df
- https://www.kodeco.com/5786-uitableview-infinite-scrolling-tutorial
- https://pedroalvarez-29395.medium.com/uitableview-infinite-scrolling-a-lot-simpler-than-you-knew-uitableviewdatasourceprefetching-51ea5c312a80
- https://johncodeos.com/how-to-add-load-more-infinite-scrolling-in-ios-using-swift/
- https://levelup.gitconnected.com/react-native-infinite-scrolling-with-react-query-3c2cc69790be#:~:text=Infinite%20Scroll%20with%20FlashList&text=We%20call%20a%20function%20to,new%20data%20will%20be%20called
  .
- https://javascript.plainenglish.io/react-native-infinite-scroll-pagination-with-flatlist-e5fe5db6c1cb
- https://blog.jscrambler.com/implementing-infinite-scroll-with-react-query-and-flatlist-in-react-native/

**Great Features**

- It lazily loads and displays pages of items as the user scrolls down your screen.
- Find more interesting features at [pub.dev](https://pub.dev/packages/infinite_scroll_pagination).

**Problems from Videos**

- NA

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/71005365/how-to-do-infinite-scrolling-in-flutter
- https://stackoverflow.com/questions/70369703/flutter-how-using-sliverappbar-with-infinite-scroll-pagination
- https://stackoverflow.com/questions/67833149/how-to-use-infinite-scroll-pagination-for-bloc-pattern
- https://stackoverflow.com/questions/75048292/how-to-implement-infinite-scroll-pagination-the-right-way
- https://stackoverflow.com/questions/68103695/how-do-infinite-scroll-pagination-in-flutter

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. In this video, you will learn how to infinite scroll a ListView, SliverGrid or SliverList.
2. Main points:
    - `numberOfPostsPerRequest` and `PagingController` to control posts.
    - `PagedListView` to show posts in the form of ListView.
3. `PagedSliverGrid` and `PagedSliverList` can also be used for infinite scroll.

**The Structured Main Content**

1. Run `dart pub add infinite_scroll_pagination` in your project's terminal to add this package
   in `pubspec.yaml` file.

   Import `import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';` where you
   want to use this package in your project.
2. We will use mock APIs of Posts section
   of [https://jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com) for demo purpose
   of this package.
3. `posts_model.dart` contains the simple model of post coming from API.

```dart
class PostModel {
  final String title;
  final String body;
  final int id;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
  });
}

```

4. `post_item_widget.dart` contains UI of post item which will be shown
   in `InfiniteScrollPaginationPage` in `infinite_scroll_pagination_page.dart`.

```dart
import 'package:flutter/material.dart';

class PostItemWidget extends StatelessWidget {
  final String title;
  final String body;
  final int id;

  const PostItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.amber,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$id: $title',
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(body, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      );
}

```

5. `infinite_scroll_pagination_page.dart` contains ListView part of Infinite Scroll Pagination Demo
   of the package.

![output gif](output.gif)

- Initialize the following:

```dart

static const numberOfPostsPerRequest = 10;

final PagingController<int, PostModel> pagingController =
PagingController(firstPageKey: 1);
```

- In `initState`, call the `addPageRequestListener` to listen page changes:

`fetchPage(fetchPage(int pageKey))` method is called here to fetch the post when page opens.

```dart
  @override
void initState() {
  pagingController.addPageRequestListener((pageKey) {
    fetchPage(pageKey);
  });
  super.initState();
}
```

`fetchPage(fetchPage(int pageKey))` method:

```dart
  Future<void> fetchPage(int pageKey) async {
  try {
    final response = await get(
      Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$numberOfPostsPerRequest"),
    );
    List responseList = json.decode(response.body);
    // debugPrint(responseList.toString());
    List<PostModel> postList = responseList
        .map((data) =>
        PostModel(
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
```

`pagingController.addStatusListener` can also be used to listen to the status pages inside
the `initState`, it is optional:

```dart 
    pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
```

- Remember to dispose the `pagingController` in the end:

```dart

@override
void dispose() {
  super.dispose();
  pagingController.dispose();
}
```

- UI of page:

```dart 

   Scaffold(
        appBar: AppBar(
          title: const Text("Infinite Scroll Pagination Package"),
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
                  }
                  return PostItemWidget(
                    id: item.id,
                    title: item.title,
                    body: item.body,
                  );
                }),
          ),
        ),
      ),
```

- `PagedListView` is of type `<PageKeyType, ItemType>` and wrapped with `RefreshIndicator` to
  refresh the page.

Here `PageKeyType` is `int` and `ItemType` is `PostModel`.

- `pagingController` and `builderDelegate` are required for `PagedListView`.
- `builderDelegate` accepts `PagedChildBuilderDelegate<ItemType>`.
  <br/>`PagedChildBuilderDelegate` object also gives the flexibility to customize error handling and
  progress operations via the following optional parameters:

    - `newPageErrorIndicatorBuilder`: This handles errors that occur when making more requests for
      data. A widget that will render beneath the already-loaded data when an error occurs.
    - `firstPageErrorIndicatorBuilder`: This handles errors that occur when making the first request
      for data. The widget assigned to this operation renders at the center of the screen because
      the screen is empty at this point.
    - `firstPageProgressIndicatorBuilder`: Widget appears at the center of the screen when the app
      requests its first paginated data.
    - `newPageProgressIndicatorBuilder`: Widget appears beneath the pre-existing data when the app
      requests more data.
    - `noItemsFoundIndicatorBuilder`: Widget that renders when the API returns an empty collection
      of data. This is not considered an error because, technically, the API call was successful but
      there was no data found
    - `noMoreItemsIndicatorBuilder`: Widget to render when the user has exhausted all the data
      returned by the API

- If `index` of itemBuilder equals to the `pagingController.itemList!.length - 1` then show text
  of `No more data` at the end.
- Otherwise, return the `PostItemWidget` with id, title and body.