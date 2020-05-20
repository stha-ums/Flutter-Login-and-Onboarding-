import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/core/utilities/invitation_code_generator.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';

class PairingSceen extends StatefulWidget {
  final UserRepository _userRepository;

  const PairingSceen({Key key, userRepository}) : 
  _userRepository = userRepository,
  assert (userRepository != null),
  super(key: key);

  @override
  _PairingSceenState createState() => _PairingSceenState();
}

class _PairingSceenState extends State<PairingSceen> {

  UserRepository get _userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    InvitationCode().generate();
    //save the pairing code with generating the random number
    return SafeArea(
      child: Column(
        children: [
          Text(
            "email",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(
            '3423523',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text('or'),
          Text('Enter your partners code'),
          // Row(children: [
          //   TextField(
          //     maxLength: 1,
          //     onSubmitted: ,
          //   ),
          //   TextField(
          //     maxLength: 1,
          //   ),
          //   TextField(
          //     maxLength: 1,
          //   ),
          //   TextField(
          //     maxLength: 1,
          //   ),
          //   TextField(
          //     maxLength: 1,
          //   ),

          // ],)
        ],
      ),
    );
  }
}
