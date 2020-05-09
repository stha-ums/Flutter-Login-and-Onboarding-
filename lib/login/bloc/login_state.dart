import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final bool hasOneUpperCase;
  final bool hasOneSpecialCharacter;
  final bool hasOneNumber;
  final bool hasEightCharacter;
  final bool isKeyboardVisible;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.errorMessage,
    @required this.hasOneUpperCase,
    @required this.hasOneSpecialCharacter,
    @required this.hasOneNumber,
    @required this.hasEightCharacter,  
    @required this.isKeyboardVisible,  
  });

  factory LoginState.empty() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage:' ',
      hasOneUpperCase:false,
      hasOneSpecialCharacter:false,
      hasOneNumber:false,
      hasEightCharacter:false,
      isKeyboardVisible:false, 
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage:' ',
      hasOneUpperCase:true,
      hasOneSpecialCharacter:true,
      hasOneNumber:true,
      hasEightCharacter:true,
      isKeyboardVisible:true,
    );
  }

  factory LoginState.failure({String failureMessage}) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage:(failureMessage==null)?' ':failureMessage,
      hasOneUpperCase:true,
      hasOneSpecialCharacter:true,
      hasOneNumber:true,
      hasEightCharacter:true,
      isKeyboardVisible:true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage:' ',
      hasOneUpperCase:true,
      hasOneSpecialCharacter:true,
      hasOneNumber:true,
      hasEightCharacter:true,
      isKeyboardVisible:true,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool hasOneUpperCase,
    bool hasOneSpecialCharacter,
    bool hasOneNumber,
    bool hasEightCharacter, 
    bool isKeyboardVisible,   
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage:' ',
      hasOneUpperCase:hasOneUpperCase,
      hasOneSpecialCharacter:hasOneSpecialCharacter,
      hasOneNumber:hasOneNumber,
      hasEightCharacter:hasEightCharacter,  
      isKeyboardVisible:isKeyboardVisible,    
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
    bool hasOneUpperCase,
    bool hasOneSpecialCharacter,
    bool hasOneNumber,
    bool hasEightCharacter,    
    bool isKeyboardVisible,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.isFailure,
      hasOneUpperCase:hasOneUpperCase??this.hasOneUpperCase,
      hasOneSpecialCharacter:hasOneSpecialCharacter??this.hasOneSpecialCharacter,
      hasOneNumber:hasOneNumber??this.hasOneNumber,
      hasEightCharacter:hasEightCharacter??this.hasEightCharacter,
      isKeyboardVisible:isKeyboardVisible??this.isKeyboardVisible,

    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage: $errorMessage,
      hasOneUpperCase:$hasOneUpperCase,
      hasOneSpecialCharacter:$hasOneSpecialCharacter,
      hasOneNumber:$hasOneNumber,
      hasEightCharacter:$hasEightCharacter,      
      isKeyboardVisible:$isKeyboardVisible,
    }''';
  }
}
