import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email, 
    String username, 
    String password, 
   
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn, this._isLoading);

  final bool _isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  // State for shifting between login and signup
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  

  // void _pickedImage(File pickedImage) {
  //   _pickImage = pickedImage;
  // }

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    // SoftKeyboard goes down after subit is done
    FocusScope.of(context).unfocus(); 
    // if(_pickImage == null && !_isLogin) {
    //   Scaffold.of(context).showSnackBar(
    //   SnackBar(content: Text('Please pick an image'), backgroundColor: Theme.of(context).errorColor,)
    //   );
    //   return;
    // }

    if (_isValid) {
      // Looks for the onSaved function in each TextFormField
      _formKey.currentState.save();
      // Since the function is in the widget and in the state we need to use the below format
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
       // _pickImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children:<Widget> [ 
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
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                      crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                   // if(!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                    ),
                    if(!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter a username with atleast 4 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (newValue) {
                          _userName = newValue;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be atleast 7 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if(widget._isLoading)
                      CircularProgressIndicator(),
                    if(!widget._isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: _trySubmit,
                      ),
                    if(!widget._isLoading)
                      FlatButton(
                        child: Text(_isLogin ? 'Create Account!' : 'I already have an account'),
                        textColor: Theme.of(context).accentColor,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                ),
                              ),
              ),
            ),
      ]
    );
  }
}
