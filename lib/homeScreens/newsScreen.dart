import 'package:flutter/material.dart';
import '../MovieDatabase.dart';

import 'package:cached_network_image/cached_network_image.dart';

final database = DatabaseProvider();

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News>? _news;
  ListView? listView;

  @override
  void initState() {
    super.initState();
    getListView();
  }

  Future<void> getListView() async {
    _news = await database.news();
    print("news");

    setState(() {
      listView = ListView.builder(
          itemCount: _news?.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return Card(
              child: ListTile(
                leading: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  imageUrl: _news![index].image,
                ),
                title: Text(_news![index].title),
                subtitle: Text("${_news![index].text.substring(0, 100)}..."),
                isThreeLine: true,
              ),
            );
          });
    });
  }

  // Future<void> getNews() async {
  //
  // }

  @override
  Widget build(BuildContext context) {
    if (listView == null) {
      return Column(children: const [CircularProgressIndicator()]);
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: const Text("News", style: TextStyle(fontSize: 24),),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
          ),
          Expanded(
            child: Container(
              child: listView,
            ),
          )
        ]));
  }
}
