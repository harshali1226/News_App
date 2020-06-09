import 'package:flutter/material.dart';
import '../screens/news_detail_screen.dart';
import '../models/news.dart';

class ItemPage extends StatefulWidget {
  final IndividualNews newsItem;
  ItemPage(this.newsItem);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  void _selectedNews(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(NewsDetailScreen.routeName, arguments: {
      'title': widget.newsItem.title,
      'author': widget.newsItem.author,
      'description': widget.newsItem.description,
      'imageUrl': widget.newsItem.imageUrl,
      'content': widget.newsItem.content
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        //  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 2),
          borderRadius: BorderRadius.circular(10),
        ),

        height: 80,
        child: SingleChildScrollView(
          child: ListTile(
            leading: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage('${widget.newsItem.imageUrl}'),
            ),
            title: Text(
              widget.newsItem.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _selectedNews(context),
          ),
        ),
      ),
    ]);
  }
}
