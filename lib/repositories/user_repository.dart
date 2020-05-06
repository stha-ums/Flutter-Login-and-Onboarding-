import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

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

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
     return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((AuthResult result){
      result.user.sendEmailVerification();
    });
  //TODO : verification email 
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    //TODO :
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<String> resetPassword({String email}) async{
    String errorMessage;
    try{
    await _firebaseAuth.sendPasswordResetEmail(email:email );
    }catch (error){
      switch(error.code){
        case "ERROR_INVALID_EMAIL":
          errorMessage = 'your email seems to be malformed';
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist";
          break;
        default:
          errorMessage = "An undefined Error Occured.";
      }
    }
    return errorMessage;
  }

}
