import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:wishwecouldtalk/core/shared_widgets/shared_widgets.dart';
import 'package:wishwecouldtalk/register/register_screen.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';
import '../authentication_bloc/authentication_bloc.dart';

import 'login.dart';

class LoginForm extends StatefulWidget {

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final KeyboardVisibilityNotification _keyboardVisibility = KeyboardVisibilityNotification();


  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _keyboardVisibility.addNewListener(
      onChange: (visible){
        onKeyboardVisibilityChange(visible);
      }
    );
   
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('${state.errorMessage}'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          //oncelogged in the login form will pop up
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
              child: GestureDetector(
                onTap: (){
                  FocusNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus){
                    currentFocus.unfocus();
                  }
                },
                child: ListView(
                  //physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFEFAF9),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.safeBlockWidth*10,
                          right:Dimensions.safeBlockWidth*10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.isKeyboardVisible?Container()
                            :Text("Sign In",
                            textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: Dimensions.safeBlockWidth*20,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                               state.isKeyboardVisible?Container():Row(
                                children: [
                                  Text("Don't have an account yet?",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: Dimensions.safeBlockWidth*6
                                  ),
                                  ),
                                  SizedBox(height:Dimensions.safeBlockHeight*10),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return RegisterScreen();
                                      }),
                                    );
                                    },
                                    child: Text(" Sign up!",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: Dimensions.safeBlockWidth*6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    )),
                                ],
                              ),
                              state.isKeyboardVisible?Container()
                              :SizedBox(height: Dimensions.safeBlockHeight*22,),

                              SizedBox(height: Dimensions.safeBlockHeight*2,)
                                  ],
                                ),
                      ),
                    ),
                     SizedBox(height: Dimensions.safeBlockHeight*4,),
                    Padding(
                      padding:  EdgeInsets.only(left:Dimensions.safeBlockWidth*10.0,right: Dimensions.safeBlockWidth*10),
                      child: TextFormField(
                        focusNode: _emailFocusNode,
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: _emailFocusNode.hasPrimaryFocus?Colors.black:Colors.grey,
                          ),
                          labelText: 'E-mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                    ),
                    SizedBox(height: Dimensions.safeBlockHeight*4,),
                    Padding(
                      padding:EdgeInsets.only(
                        left:Dimensions.safeBlockWidth*10,
                        right: Dimensions.safeBlockWidth*10),
                      child: TextFormField(
                        cursorColor: Colors.red,
                        focusNode: _passwordFocusNode,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          focusColor:Colors.black,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: _passwordFocusNode.hasPrimaryFocus?Colors.black:Colors.grey,
                          ),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid ? 'Invalid Password' : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:Dimensions.safeBlockWidth*3,right: Dimensions.safeBlockWidth*10),
                      child: Row(
                        children: [
                          PasswordResetButton(),
                        ],
                      ),
                    ),
                    state.isKeyboardVisible?Container()
                    :SizedBox(height: Dimensions.safeBlockHeight*4,),
                    SizedBox(height: Dimensions.safeBlockHeight*2,),
                    Padding(
                      padding:  EdgeInsets.only(left:Dimensions.safeBlockWidth*10,right:Dimensions.safeBlockWidth*10),
                      child: PasswordValidationIndicator(state:state),
                    ),
                    
                    state.isKeyboardVisible?Container()
                    :SizedBox(height: Dimensions.safeBlockHeight*10,),
                    SizedBox(height: Dimensions.safeBlockHeight*4),

                    Padding(
                      padding: EdgeInsets.only(left:Dimensions.safeBlockWidth*10,right: Dimensions.safeBlockWidth*10),
                      child: LoginButton(
                            onPressed: isLoginButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                          ),
                    ),
                    SizedBox(height: Dimensions.safeBlockHeight*5,),
                     state.isKeyboardVisible?Container():Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('or continue with',
                        style: TextStyle(
                          fontSize: Dimensions.safeBlockWidth*6,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                        ),
                        ),
                        FacebookLoginButton(),
                        GoogleLoginButton(),
                      ],
                    )
                  ],
                ),
              ),
            );
        },
      )
    );
  }
  bool isDisposed =false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _keyboardVisibility.dispose();
    isDisposed =true;
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void onKeyboardVisibilityChange(visible){
    if(isDisposed) return ;
    _loginBloc.add(KeyboardVisibilityChanged(visible: visible));
  }
}
