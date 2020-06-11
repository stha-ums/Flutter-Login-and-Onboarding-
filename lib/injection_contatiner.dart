import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'authentication_bloc/authentication_bloc.dart';
import 'login/login.dart';
import 'models/user_model.dart';
import 'onbording_screen/bloc/onboarding_bloc.dart';
import 'pairing/pairing.dart';
import 'password_reset/bloc/passwordreset_bloc.dart';
import 'register/register.dart';
import 'repositories/database_repository.dart';
import 'repositories/user_repository.dart';
import 'style/dimentions.dart';

 final sl = GetIt.instance;

Future <void> init() async {

  
  //! authentication
  //bloc
  sl.registerFactory(
    () => AuthenticationBloc(
      userRepository: sl(),
    ),
  );

  //user repository

  sl.registerLazySingleton(
    () => UserRepository(
      firebaseAuth: sl(),
      googleSignin: sl(),
    ),
  );

  //!login
  //bloc
  sl.registerFactory(
    () => LoginBloc(
      userRepository: sl(),
    ),
  );
  //!onboarding
  //bloc
  sl.registerFactory(
    () => OnboardingBloc(),
  );
  //! pairing
  sl.registerFactory(
    () => PairingBloc(
      userDataRepository: sl(),
    ),
  );

  //userdatarepository
  sl.registerLazySingleton(
    () => UserDataRepository(
      firestore: sl(),
      userData: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => Firestore.instance,
  );
  //userdata model
  sl.registerLazySingleton(
    () => UserData(),
  );

  //!password resest
  //bloc
  sl.registerFactory(
    () => PasswordresetBloc(
      userRepository: sl(),
    ),
  );
  //! register
  //bloc
  sl.registerFactory(
    () => RegisterBloc(
      userRepository: sl(),
    ),
  );
  //!style
  sl.registerSingleton(
    Dimensions(),
  );

  

  //! external

  sl.registerLazySingleton(
    () => FirebaseAuth.instance,
  );

  sl.registerLazySingleton(
    () => GoogleSignIn(),
  );

  sl.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );
  
  sl.registerLazySingleton(
    () => http.Client(),
  );
}
