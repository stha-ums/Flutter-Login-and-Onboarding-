import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PasswordresetEvent extends Equatable {
  const PasswordresetEvent();

  @override
  List<Object> get props => [];
}


class EmailChangedReset extends PasswordresetEvent {
  final String email;

  const EmailChangedReset({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}


class Submitted extends PasswordresetEvent {
  final String email;

  const Submitted({
    @required this.email,
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'Submitted { email: $email }';
  }
}
