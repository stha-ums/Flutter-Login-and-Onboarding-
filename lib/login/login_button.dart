import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(Dimensions.blockHeight*3.5),
      disabledColor: Colors.red[400],
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0),
      ),
      onPressed: _onPressed,
      child: Text('Sign in',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 1
      ),
      ), 
    );
  }
}
