import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = '/news_detail';
  @override
  Widget build(BuildContext context) {
    final newsItem = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final author = newsItem['author'];
    final description = newsItem['description'];
    final imageUrl = newsItem['imageUrl'];
    final content = newsItem['content'];

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(author,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            background: Container(
              width: double.infinity,
              height: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: FittedBox(
                child: Image.network(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text('Author: $author',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text('Date:', style: TextStyle(color: Colors.grey)),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.bottomRight,
                child: UndoSnackBar(),
              ),
            SizedBox(height: 800)
          ]),
        ),
      ],
    ));
  }
}

class UndoSnackBar extends StatelessWidget {
  const UndoSnackBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Item Saved'),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {},
            ),
          ),
        );
      } 
    );
  }
}
