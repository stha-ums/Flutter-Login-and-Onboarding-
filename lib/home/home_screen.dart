import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';

import '../authentication_bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserDataRepository userDataRepository;

  const HomeScreen({Key key, this.userDataRepository}) 
  : assert (userDataRepository != null), 
    super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome ${userDataRepository.userData.userId}')),
        ],
      ),
    );
  }
}
