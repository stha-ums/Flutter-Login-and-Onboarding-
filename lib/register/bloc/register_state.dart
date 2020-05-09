import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final bool ispasswordMatched;
  final bool hasOneUpperCase;
  final bool hasOneSpecialCharacter;
  final bool hasOneNumber;
  final bool hasEightCharacter;
  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.errorMessage,
    @required this.ispasswordMatched,
    @required this.hasOneUpperCase,
    @required this.hasOneSpecialCharacter,
    @required this.hasOneNumber,
    @required this.hasEightCharacter,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage :' ',
      ispasswordMatched: true,
      hasOneUpperCase:false,
      hasOneSpecialCharacter:false,
      hasOneNumber:false,
      hasEightCharacter:false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage :' ',
      ispasswordMatched:true,
      hasOneUpperCase:true,
      hasOneSpecialCharacter:true,
      hasOneNumber:true,
      hasEightCharacter:true,
    );
  }

  factory RegisterState.failure({String failureMessage}) {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage :(failureMessage==null)?' ':failureMessage,
      ispasswordMatched:true,
      hasOneUpperCase:true,
      hasOneSpecialCharacter:true,
      hasOneNumber:true,
      hasEightCharacter:true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage :' ',
      ispasswordMatched:true,
      hasOneUpperCase:true,
      hasOneSpecialCharacter:true,
      hasOneNumber:true,
      hasEightCharacter:true,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool ispasswordMatched,
    bool hasOneUpperCase,
    bool hasOneSpecialCharacter,
    bool hasOneNumber,
    bool hasEightCharacter,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage :' ',
      ispasswordMatched:ispasswordMatched,
      hasOneUpperCase:hasOneUpperCase,
      hasOneSpecialCharacter:hasOneSpecialCharacter,
      hasOneNumber:hasOneNumber,
      hasEightCharacter:hasEightCharacter,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String errorMessage :' ',
    bool ispasswordMatched,
    bool hasOneUpperCase,
    bool hasOneSpecialCharacter,
    bool hasOneNumber,
    bool hasEightCharacter,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage :errorMessage ?? this.errorMessage,
      ispasswordMatched: ispasswordMatched ?? this.ispasswordMatched,
      hasOneUpperCase:hasOneUpperCase??this.hasOneUpperCase,
      hasOneSpecialCharacter:hasOneSpecialCharacter??this.hasOneSpecialCharacter,
      hasOneNumber:hasOneNumber??this.hasOneNumber,
      hasEightCharacter:hasEightCharacter??this.hasEightCharacter,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage:$errorMessage,
      ispasswordMatched:$ispasswordMatched,
      hasOneUpperCase:$hasOneUpperCase,
      hasOneSpecialCharacter:$hasOneSpecialCharacter,
      hasOneNumber:$hasOneNumber,
      hasEightCharacter:$hasEightCharacter,
    }''';
  }
}
