import 'package:New_App/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/auth_screen.dart';
import 'package:flutter/material.dart';
import './screens/news_detail_screen.dart';
import 'package:provider/provider.dart';

import './screens/news_list_screen.dart';
import './screens/home_screen.dart';

import './models/news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value: News(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.indigo,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
            )
          ),
          home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx, userSnapshot) {
            if(userSnapshot.hasData) {
              return HomeScreen();
            }
            return AuthScreen();
          }),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            NewsListScreen.routeName: (ctx) => NewsListScreen(),
            NewsDetailScreen.routeName: (ctx) => NewsDetailScreen()
          }),
    );
  }
}
