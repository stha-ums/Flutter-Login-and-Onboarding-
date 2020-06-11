import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/utilities/utils.dart';
import '../../repositories/repositories.dart';
import 'passwordreset_event.dart';
import 'passwordreset_state.dart';

class PasswordresetBloc extends Bloc<PasswordresetEvent, PasswordresetState> {

  final UserRepository _userRepository;

  PasswordresetBloc({@required userRepository})
    :assert(userRepository!= null),
    _userRepository=userRepository;

  @override
  PasswordresetState get initialState => PasswordresetState.empty();

    @override
  Stream<Transition<PasswordresetEvent, PasswordresetState>> transformEvents(
    Stream<PasswordresetEvent> events,
    TransitionFunction<PasswordresetEvent, PasswordresetState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChangedReset);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChangedReset);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }


  @override
  Stream<PasswordresetState> mapEventToState(
    PasswordresetEvent event,
  ) async* {
    if (event is EmailChangedReset) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email);
    }
  }

  Stream<PasswordresetState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<PasswordresetState> _mapFormSubmittedToState(
    String email
  ) async* {
      
    yield PasswordresetState.loading();
    try {
      String sucessStatus = await _userRepository.resetPassword(
        email: email,
      );
      if(sucessStatus == null){
        yield PasswordresetState.success();
      }
      else {
        yield PasswordresetState.failure(failureMessage: sucessStatus);
      }
    } catch (e) {
      yield PasswordresetState.failure();
    }
  }

}








