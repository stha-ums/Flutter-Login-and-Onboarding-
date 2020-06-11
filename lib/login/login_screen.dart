import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../injection_contatiner.dart' as di;

import 'login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        iconTheme: IconThemeData(
          color:Colors.red,
        ),
        elevation: 0,
        backgroundColor: Color(0xffFEFAF9),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => di.sl<LoginBloc>(),
        child: LoginForm(),
      ),
    );
  }
}
