import 'package:New_App/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  
  void _submitAuthForm(String email, String username, String password, bool isLogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
     authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } else {
      authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Firestore.instance.collection('users').document(authResult.user.uid).setData({
        'username': username,
        'password': password,
        'email': email
      });
    }

    
    } on PlatformException catch (err) {
      var message = 'An error occurred, please enter your valid credentials';
      if(err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red,));
       setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
       setState(() {
        _isLoading = false;
      });
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}