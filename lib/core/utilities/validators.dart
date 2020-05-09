class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$',
  );

  static final RegExp _hasOnedigit =RegExp(r'^(?=(.*[\d]){1,}).*$');
  static final RegExp _hasOneUpperCase = RegExp(r'^(?=.*?[A-Z]).*$');
  static final RegExp _hasOneSpecialCharacter =RegExp(r'^(?=(.*[\W]){1,}).*$');
  static final RegExp _hasEightCharacter = RegExp(r'^(?=.{8,}$).*$');

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }
  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
  
  static isPasswordMatched(String password,String password2){
    return password == password2; 
  }

  static hasOneUpperCase(String password){
    return _hasOneUpperCase.hasMatch(password);
  }

  static hasOneSpecialCharacter(String password){
    return _hasOneSpecialCharacter.hasMatch(password);
  }

  static hasOneNumber(String password){
    return _hasOnedigit.hasMatch(password);
  }

  static hasEightCharacter(String password){
    return _hasEightCharacter.hasMatch(password);
  }

}