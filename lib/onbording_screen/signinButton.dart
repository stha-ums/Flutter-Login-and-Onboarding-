import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/login/login_screen.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';
import '../repositories/repositories.dart';

class SignInButton extends StatelessWidget {
  final UserRepository _userRepository;

  SignInButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return RaisedButton(
      elevation: 0,
       padding: EdgeInsets.all(Dimensions.blockHeight*3.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.blockHeight*40),
        ) ,
      child: Text(
        'Sign in', 
        style: TextStyle(
        color:Colors.white,
        fontSize: Dimensions.blockWidth*7,
        letterSpacing: Dimensions.blockWidth*.7,
        )
        ,
        ),

      onPressed:() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return LoginScreen(userRepository: _userRepository);
          }),
        );
      },
      color: Colors.red,
      );
  }
}