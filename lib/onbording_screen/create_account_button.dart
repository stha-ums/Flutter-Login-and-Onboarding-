import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';

import '../register/register.dart';
import '../repositories/repositories.dart';

class CreateAccountButton extends StatelessWidget {
  // final UserRepository _userRepository;

  // CreateAccountButton({Key key, @required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
     Dimensions().init(context);
     return RaisedButton(
       elevation: 0,
      padding: EdgeInsets.all(Dimensions.blockHeight*3.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.blockHeight*40),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen();
          }),
        );
      },
      child: Text(
        'Create an account',
        style: TextStyle(
        color:Colors.red,
        fontSize: Dimensions.blockWidth*7,
        letterSpacing: Dimensions.blockWidth*.7,
        ),
      ),
      color: Colors.red[50],
    );
  }
}



