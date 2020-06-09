import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news.dart';
import '../widgets/item_page.dart';

class NewsListScreen extends StatefulWidget {
  static const routeName = '/newslist';
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final catId = routeArgs['id'];
    final catTitle = routeArgs['title'];
    return Scaffold(
        appBar: AppBar(
          title: Text(catTitle),
        ),
        body: FutureBuilder(
            future: Provider.of<News>(context, listen: false).getData(catId),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error != null) {
                  return Center(child: Text('Turn on the network Connection for more News!!'));
                } else {
                  return Consumer<News>(
                    builder: (context, value, child) => ListView.builder(
                        itemCount: value.item.length,
                        itemBuilder: (ctx, i) => ItemPage(value.item[i])),
                  );
                }
              }
            }));
  }
}
