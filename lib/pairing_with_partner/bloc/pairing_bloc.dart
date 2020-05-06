import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pairing_event.dart';
part 'pairing_state.dart';

class PairingBloc extends Bloc<PairingEvent, PairingState> {
  @override
  PairingState get initialState => PairingInitial();

  @override
  Stream<PairingState> mapEventToState(
    PairingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
