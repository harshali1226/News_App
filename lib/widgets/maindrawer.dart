import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, Function ontapHandler){
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onTap: ontapHandler,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.only(top: 30,left: 16),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.centerLeft,
            child: Text('Navigations', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
          ),
          SizedBox(height: 20,),
          buildListTile(
            'Home',
            Icons.home,
            () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          SizedBox(height: 20,),
          buildListTile(
            'Read Later',
            Icons.favorite,
            () {}
          ),
          SizedBox(height: 20,),
          buildListTile(
            'Logout',
            Icons.exit_to_app,
            () {
              FirebaseAuth.instance.signOut();
            }
          ),
        ],
      ),
    );
  }
}