import 'package:flutter/material.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';
import 'package:wishwecouldtalk/password_reset/passwordreset.dart';

class PasswordResetButton extends StatelessWidget {
  final UserRepository _userRepository;

  PasswordResetButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'reset password',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PasswordResetScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
