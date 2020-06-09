import 'package:flutter/material.dart';

import '../data/category_data.dart';
import '../widgets/home_grid.dart';
import '../widgets/maindrawer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  // final String id;
  // final String title;
  // HomeScreen(this.id, this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'),
      ),
      drawer: MainDrawer(),
        body: GridView(
        padding: EdgeInsets.all(20),
        children: Categories.map((e) => HomeGrid(
          e.id,
          e.title,
          e.color
        )).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 210,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      
      ),
    );
  }
}