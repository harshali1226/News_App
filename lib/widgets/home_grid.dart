import 'package:flutter/material.dart';
import '../screens/news_list_screen.dart';
import '../screens/news_list_screen.dart';

class HomeGrid extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  HomeGrid(this.id, this.title, this.color);

  void selectNews(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(NewsListScreen.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectNews(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
