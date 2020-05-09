import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      iconSize: 30,
      color: Colors.red,
      icon: Icon(FontAwesomeIcons.google), onPressed: (){
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
        }
      );
  }
}
