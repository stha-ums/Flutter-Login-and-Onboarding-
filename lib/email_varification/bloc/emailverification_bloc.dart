import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'emailverification_event.dart';
part 'emailverification_state.dart';

class EmailverificationBloc extends Bloc<EmailverificationEvent, EmailverificationState> {
  @override
  EmailverificationState get initialState => EmailverificationInitial();

  @override
  Stream<EmailverificationState> mapEventToState(
    EmailverificationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
