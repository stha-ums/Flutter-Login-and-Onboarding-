import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc/authentication_bloc.dart';
import 'core/utilities/utils.dart';
import 'home/home_screen.dart';
import 'injection_contatiner.dart' as di;
import 'onbording_screen/onboadring_Screen.dart';
import 'pairing/pairing.dart';
//import 'repositories/repositories.dart';
import 'splash_screen.dart';
import 'style/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
     create: (context) => di.sl<AuthenticationBloc>()..add(AppStarted()),
      // create: (context) => AuthenticationBloc(
      //   userRepository: userRepository,
      // )..add(AppStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  // final UserRepository _userRepository;

  // App({Key key, @required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return OnboardingScreen();
          }
          if (state is Authenticated) {
            return BlocProvider(
              create: (context) =>
                    di.sl<PairingBloc>()..add(JusLoggedIn(userID: state.userID)),
              child: PairOrHome(),
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}

class PairOrHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PairingBloc, PairingState>(
        builder: (context, state) {
          if (state is Paired)
            //need to send userID
            return HomeScreen(
              userDataRepository: state.userDataRepository,
            );
          //need to send somthing
          if (state is NotPaired)
            //generate random number of 8 digit and save to the server
            return PairingSceen();
          //no need to send anything
          return SplashScreen();
        },
      ),
    );
  }
}
