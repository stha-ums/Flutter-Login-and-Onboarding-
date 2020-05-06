part of 'emailvarification_bloc.dart';

abstract class EmailvarificationState extends Equatable {
  const EmailvarificationState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends EmailvarificationState {

}

class EmailVerified extends EmailvarificationState{}
class EmailNotVerified extends EmailvarificationState{}