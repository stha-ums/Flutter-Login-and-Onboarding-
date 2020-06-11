import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';

class SubmitInvitationCodeButton extends StatelessWidget {

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
        'Submit', 
        style: TextStyle(
        color:Colors.white,
        fontSize: Dimensions.blockWidth*7,
        letterSpacing: Dimensions.blockWidth*.7,
        )
        ,
        ),

      onPressed:() {
        
        //bloc add event
      },
      color: Colors.red,
      );
  }
}