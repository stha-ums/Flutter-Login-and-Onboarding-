part of 'emailverification_bloc.dart';

abstract class EmailverificationState extends Equatable {
  const EmailverificationState();
    @override
  List<Object> get props => [];
}

class EmailverificationInitial extends EmailverificationState {}

class EmailVerified extends EmailverificationInitial{}
class EmailUnverified extends EmailverificationInitial{}