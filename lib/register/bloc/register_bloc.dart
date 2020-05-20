import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wishwecouldtalk/register/bloc/bloc.dart';

import '../../core/utilities/utils.dart';
import '../../repositories/repositories.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }else if (event is PasswordChangedSecond){
      yield* _mapFromPasswordChangedSecond(event.password,event.password2);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
      hasEightCharacter: Validators.hasEightCharacter(password),
      hasOneSpecialCharacter:Validators.hasOneSpecialCharacter(password) ,
      hasOneNumber: Validators.hasOneNumber(password),
      hasOneUpperCase: Validators.hasOneUpperCase(password),
    );
  }

    Stream<RegisterState> _mapFromPasswordChangedSecond(String password,String password2) async* {
    yield state.update(
      ispasswordMatched: Validators.isPasswordMatched(password,password2),
    );
  }


  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      String status = await _userRepository.signUp(
        email: email,
        password: password,
      );
      if(status == null){
      yield RegisterState.success();
      }
      else 
      yield RegisterState.failure(failureMessage: status);
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
