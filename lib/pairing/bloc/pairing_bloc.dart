import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wishwecouldtalk/pairing/bloc/bloc.dart';

import 'package:wishwecouldtalk/repositories/repositories.dart';


class PairingBloc extends Bloc<PairingEvent, PairingState> {
  final UserDataRepository _userDataRepository;

  PairingBloc({@required UserDataRepository userDataRepository})
  :assert(userDataRepository != null),
  _userDataRepository=userDataRepository;
  
  @override
  PairingState get initialState => UninitializedPair();

  @override
  Stream<PairingState> mapEventToState(
    PairingEvent event,
  ) async* {
    if(event is JusLoggedIn){
      yield* _mapJustLoggedInToState(event.userID);
    }else if(event is Pair){
      yield* _mapPairToState();
    }else if(event is CancelPair){
      yield* _mapCancelPairToState();
    }
  }

  Stream<PairingState> _mapJustLoggedInToState(String userID) async*{
    //getdata first
    await _userDataRepository.getUserData(userID);
    final isPaired = _userDataRepository.isPaired();
    if(isPaired){
      yield Paired(userDataRepository: _userDataRepository);
    }
  else if (isPaired == null || isPaired == false) {
    yield NotPaired();
  }
  }

  Stream<PairingState> _mapPairToState() async*{

    //here the data should be submitted of user to the data bse which is vacent and if pairing
    // success than send paired signal 
    yield Paired(userDataRepository: _userDataRepository);
  }

  Stream<PairingState> _mapCancelPairToState() async*{
    yield NotPaired();
    ///this function takes user repository to delete the user
    _userDataRepository.deleteAccountAndExit();
  }
  
}
