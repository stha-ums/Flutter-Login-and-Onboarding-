import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';

import '../injection_contatiner.dart' as di;
import 'passwordreset.dart';


class PasswordResetScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Center(
        child: BlocProvider<PasswordresetBloc>(
          create: (context) => PasswordresetBloc(userRepository: di.sl<UserRepository>()), //TODO: why this doesnt work like the way it is suppose to be
          child: PasswordResetForm(),
        ),
      ),
    );
  }
}

//di.sl<PasswordresetBloc>()
