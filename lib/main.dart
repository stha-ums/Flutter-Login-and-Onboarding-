import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc/authentication_bloc.dart';
import 'core/utilities/utils.dart';
import 'home/home_screen.dart';
import 'onbording_screen/onboadring_Screen.dart';
import 'repositories/repositories.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return OnboardingScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
