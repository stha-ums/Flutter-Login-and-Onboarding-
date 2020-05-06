import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'emailvarification_event.dart';
part 'emailvarification_state.dart';

class EmailvarificationBloc extends Bloc<EmailvarificationEvent, EmailvarificationState> {
  @override
  EmailvarificationState get initialState => Uninitialized();

  @override
  Stream<EmailvarificationState> mapEventToState(
    EmailvarificationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
