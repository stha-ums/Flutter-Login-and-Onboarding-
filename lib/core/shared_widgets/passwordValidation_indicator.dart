import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';

class PasswordValidationIndicator extends StatelessWidget {
  final state;
  const PasswordValidationIndicator({Key key, this.state}) 
  : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Icon(Icons.done,
            color: (state.hasOneUpperCase!= null && state.hasOneUpperCase)?Colors.red:Colors.black,),
            Text('One uppercase character'),
              ],
            ),
            SizedBox(height: Dimensions.safeBlockHeight*6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.done,
                  color:(state.hasOneNumber!= null && state.hasOneNumber)?Colors.red:Colors.black,
                  ),
                Text('One number'),
              ],
            ),
          ],
        ),                     
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.done,
                color:(state.hasOneSpecialCharacter!= null && state.hasOneSpecialCharacter)?Colors.red:Colors.black,
                ),
                Text(
                  'One special Character',
                  textAlign: TextAlign.start,),
                  ],
            ),
            SizedBox(height: Dimensions.safeBlockHeight*6,),
            Row(
              children: [
                Icon(Icons.done,
                  color:(state.hasEightCharacter!= null && state.hasEightCharacter)?Colors.red:Colors.black,
                  ),
                  Text(
                    'Minimun 8 character',
                    textAlign: TextAlign.start),
              ],
            ),
          ],
        ),
      ],
    );
  }
}