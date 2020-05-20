import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wishwecouldtalk/repositories/database_repository.dart';

abstract class PairingState extends Equatable {
  const PairingState();

  @override
  List<Object> get props => [];
}

class UninitializedPair extends PairingState{}

class Paired extends PairingState{
  final UserDataRepository userDataRepository;

  Paired({@required this.userDataRepository}):
  assert(userDataRepository!= null);

  @override
  List<Object> get props => [userDataRepository];
  
  @override
    String toString() => '''
    _userDataRepository: ${userDataRepository.toString()}
    ''';

}

class NotPaired extends PairingState{}

