import 'package:meta/meta.dart';

@immutable 
class OnboardingState{
  final int selectedIndex;

  OnboardingState({this.selectedIndex});
  factory OnboardingState.initial(){
    
    return OnboardingState(selectedIndex : 0);
  }

  factory OnboardingState.selected({int currrentIndex}){
    
    return OnboardingState(selectedIndex : currrentIndex);
  }

  OnboardingState update({int currrentIndex}){
    
    return copyWith(selectedIndexs : currrentIndex);
  }
  OnboardingState copyWith({
    int selectedIndexs
  }){
    return OnboardingState(
      selectedIndex:selectedIndexs??this.selectedIndex
    );
  }
}