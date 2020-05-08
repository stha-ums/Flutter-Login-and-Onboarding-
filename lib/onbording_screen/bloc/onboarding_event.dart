import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
    @override
  List<Object> get props => [];
}
class ScrolledTabView extends OnboardingEvent{
final int currentIndex;

  ScrolledTabView(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];

    @override
  String toString() => 'EmailChanged { currentIndex :$currentIndex }';

}