import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email, String password, String username, bool isLogin, BuildContext ctx) submitfn;
  AuthForm(this.submitfn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  var _isLogin = false;
  var _userUsername = '';
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState.save();
      widget.submitfn(
        _userEmail.trim(),
        _userPassword.trim(),
       _userUsername.trim(),
       _isLogin,
       context, 
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
            fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: AssetImage('assets/jen.jpg'),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
            ),
                Form(
                  key: _formKey,
                  child: Theme(
                    data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
                        
                      )
                    ),
                      child: Container(
                      
                        padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if(value.isEmpty || !value.contains('@')){
                              return 'Please provide valid email address';
                            }
                            return null;
                            
                          },
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _userEmail = value;
                        },
                        ),
                        if(!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          validator: (value) {
                            if(value.isEmpty || value.length < 4){
                              return 'Please enter more than 4 characters';
                            }
                            return null;
                            
                          },
                        decoration: InputDecoration(labelText: 'Username'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _userUsername = value;
                        },
                        ),
                        
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if(value.isEmpty || value.length < 5){
                              return 'Please enter more than 5 characters';
                            }
                            return null;
                            
                          },
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                       // textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _userPassword = value;
                        },
                        ),
                        SizedBox(height: 20),
                        if(widget.isLoading) CircularProgressIndicator(),
                        if(!widget.isLoading)
                          MaterialButton(onPressed: _trySubmit,
                          height: 45,
                          minWidth: 70,
                          padding: EdgeInsets.all(10),
                          color: Colors.teal,
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                          splashColor: Colors.redAccent,
                        ),
                        
                        if(!widget.isLoading)
                          FlatButton(
                            child: Text(_isLogin ? 'Create an account' : 'I already have an account',style: TextStyle(color: Colors.teal),),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            }
                          ),
                      ] 
                    ),
                                      ),
                  )
                  )
              
            
        ],
    );
  }
}