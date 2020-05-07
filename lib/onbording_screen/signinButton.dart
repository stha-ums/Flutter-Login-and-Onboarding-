import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/login/login_screen.dart';
import '../repositories/repositories.dart';

class SignInButton extends StatelessWidget {
  final UserRepository _userRepository;

  SignInButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        ) ,
      child: Text('Sign in'),
      onPressed:() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return LoginScreen(userRepository: _userRepository);
          }),
        );
      },
      color: Colors.redAccent,
      );
  }
}