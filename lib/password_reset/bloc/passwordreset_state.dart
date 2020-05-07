import 'package:meta/meta.dart';


@immutable
class PasswordresetState{
  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  
  const PasswordresetState({
    @required this.isEmailValid, 
    @required this.isSubmitting, 
    @required this.isSuccess, 
    @required this.isFailure,
    @required this.errorMessage
  });

  bool get isFormValid => isEmailValid;

  factory PasswordresetState.empty(){
    return PasswordresetState(
      isEmailValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: ' ',
    );
  }

  factory PasswordresetState.loading(){
    return PasswordresetState(
      isEmailValid: true, 
      isSubmitting: true, 
      isSuccess: false, 
      isFailure: false,
      errorMessage: ' '
      );
  }
  ///reset password
  ///thows error if occurs else returns null
  factory PasswordresetState.failure({String failureMessage}){
    return PasswordresetState(
      isEmailValid: true, 
      isSubmitting: true, 
      isSuccess: false, 
      isFailure: true,
      errorMessage: (failureMessage==null)?' ':failureMessage,
    );
  }
  factory PasswordresetState.success(){
    return PasswordresetState(
      isEmailValid: true, 
      isSubmitting: true, 
      isSuccess: true, 
      isFailure: false,
      errorMessage: ' ',);
  }
  PasswordresetState update({
    bool isEmailValid,
  }){
    return copyWith(
      isEmailValid: isEmailValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: ' ',
    );
  }
PasswordresetState copyWith({
    bool isEmailValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }){
    return PasswordresetState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  } 

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      error message: $errorMessage,
    }''';
  }

}
