import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      
      iconSize: 30,
      color: Colors.blue,
      icon: Icon(FontAwesomeIcons.facebookF), onPressed: (){});
    
  
  }
}
