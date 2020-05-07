import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/onbording_screen/create_account_button.dart';
import 'package:wishwecouldtalk/onbording_screen/signinButton.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';

class OnboardingScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const OnboardingScreen({Key key, userRepository}) 
    :_userRepository =userRepository, 
    assert (userRepository != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignInButton(userRepository :_userRepository),
          CreateAccountButton(userRepository :_userRepository),
        ],
      ),
    );
  }
}