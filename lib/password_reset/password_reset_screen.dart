import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/repositories.dart';
import 'passwordreset.dart';


class PasswordResetScreen extends StatelessWidget {
  final UserRepository _userRepository;

  PasswordResetScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Center(
        child: BlocProvider<PasswordresetBloc>(
          create: (context) => PasswordresetBloc(userRepository: _userRepository),
          child: PasswordResetForm(),
        ),
      ),
    );
  }
}
