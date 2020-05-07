import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  ///constructor of an UserRepository
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  ///SignIn with google
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  ///signIn with email and password 
  ///sends error message if occured otherwise null
  Future<String> signInWithCredentials(String email, String password) async{
    String errorMessage;
    try{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    }catch(error){
      switch (error.code){
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Invalid email";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Incorrect Password";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User not found";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "Account is Disabled";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "To many login requests";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = " Email & Password accounts are not enabled";
          break;
        default:
          errorMessage = "Please check your internet connection";
      }
    }
   return errorMessage??null;
  }

  ///signUp with Email and password
  ///sends error message if occured other wise null
  Future<String> signUp({String email, String password}) async {
    String errorMessage;
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((AuthResult result){
      result.user.sendEmailVerification();
    });
    }
    catch(error){
      switch (error.code)
      {
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "The Password is weak";
        break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "The email is invalid";
        break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "The account with this email already exists";
        break;
        default:
          errorMessage = "Please check your internet connection";
      }
    }
    return errorMessage;
  }
///logout from current user
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  ///Check if anyone is signedin
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return (currentUser==null)?false:true;
  }

  ///chech wether the user has verified email or not
  Future<bool> checkVerified() async {
    return (await _firebaseAuth.currentUser()).isEmailVerified ;
  }

  //get id of logged in user
  Future<String> getUserID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  ///get the email of logged in user
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  //update Password of logged in user 
  ///returns String of error message if occured other wise returns null
  Future <String> updatePassword({String newPassword}) async {
    String errorMessage;
    try {
    (await _firebaseAuth.currentUser()).updatePassword(newPassword);
    }catch(error){
      switch(error.code){
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Password is too weak";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "The account is disabled";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage ="The account is not found";
          break;
        case "ERROR_REQUIRES_RECENT_LOGIN":
          errorMessage ="Recent timing error occured please relogin";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Email & Password accounts are not enabled";
          break;
        default:
          errorMessage = "Please check your internet connection";
      }
    }
     return errorMessage??null;
  }
///update Password of current user
///returns error message if occured
  Future<String> resetPassword({String email}) async{
    String errorMessage;
    try{
    await _firebaseAuth.sendPasswordResetEmail(email:email );
    }catch (error){
      switch(error.code){
        case "ERROR_INVALID_EMAIL":
          errorMessage = 'Your email format is invalid';
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist";
          break;
        default:
          errorMessage = "Please check your internet connection";
      }
    }
    return errorMessage??null;
  }
  
  //update email of existing user
  Future <String> updateEmailAddress(String newEmail) async{
    String errorMessage;
    try{
       (await _firebaseAuth.currentUser()).updateEmail(newEmail);
    }catch(error){
      switch(error.code){
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "incorrect email";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "The account has been disabled, contact us";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "The user accoount not found";
          break;
        case "ERROR_REQUIRES_RECENT_LOGIN":
          errorMessage = "Error occured, try logging in again";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Email & Password accounts are not enabled.";
          break;
      }
    }
    return errorMessage??null;
  }
  /// remaining to implelmetn 
  /// follow this 
  /// https://stackoverflow.com/questions/50986191/flutter-firebase-auth-updateprofile-method-is-not-working
  Future <String> updateUserProfile(UserUpdateInfo userUpdateInfo) async {

    (await _firebaseAuth.currentUser()).updateProfile(userUpdateInfo);
    return 'errorMessage';

  }

}
