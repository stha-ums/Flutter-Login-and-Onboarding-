import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishwecouldtalk/injection_contatiner.dart' as di;

import 'register.dart';

class RegisterScreen extends StatelessWidget {
  // final UserRepository _userRepository;

  // RegisterScreen({Key key, @required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => di.sl<RegisterBloc>(),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
