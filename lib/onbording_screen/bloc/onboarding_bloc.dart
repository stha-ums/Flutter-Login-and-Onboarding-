import 'dart:async';

import 'package:bloc/bloc.dart';

import './onboarding_event.dart';
import './onboarding_state.dart';


class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  @override
  OnboardingState get initialState => OnboardingState.initial();

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if(event is ScrolledTabView){
      yield* _mapScrolledTabViewToState(event.currentIndex);
    }
  }

  Stream<OnboardingState>_mapScrolledTabViewToState(index) async*{
    yield state.update(currrentIndex: index);
  }
}
