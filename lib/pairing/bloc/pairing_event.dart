import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';

abstract class PairingEvent extends Equatable {
  const PairingEvent();
  @override
  List<Object> get props => throw UnimplementedError();
}

class JusLoggedIn extends PairingEvent{
  final String userID;
  JusLoggedIn({@required this.userID});

  @override
  List<Object> get props => [userID];

  @override
  String toString() {
    return '''
    userId : $userID''';
  }
}

class Pair extends PairingEvent{}

class CancelPair extends PairingEvent{
  final UserRepository userRepository;

  CancelPair(this.userRepository);

  @override
  List<Object> get props => [userRepository];
}