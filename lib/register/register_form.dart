import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishwecouldtalk/core/shared_widgets/shared_widgets.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';

import '../authentication_bloc/authentication_bloc.dart';
import 'register.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerSecond = TextEditingController();
  final FocusNode _focusNodeEmail =FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmedPassword = FocusNode();

  final GlobalKey formKey = GlobalKey();


  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && 
      _passwordController.text.isNotEmpty &&
      _passwordControllerSecond.text.isNotEmpty&&
      _passwordController.text == _passwordControllerSecond.text
      ;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _passwordControllerSecond.addListener(_onPasswordChangeSecond);
  }

  @override
  Widget build(BuildContext context) {
     Dimensions().init(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).popUntil(ModalRoute.withName('/')); //to pop all the routes
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${state.errorMessage}'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  //SizedBox(height: Dimensions.screenHeight - formKey.currentContext.size.height),
                  //TODO for getting the height of the listview
                  TextFormField(
                    focusNode: _focusNodeEmail,
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,
                      color:_focusNodeEmail.hasPrimaryFocus?Colors.black:Colors.grey ,
                      ),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    focusNode: _focusNodePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,
                      color: _focusNodePassword.hasPrimaryFocus?Colors.black:Colors.grey,
                      ),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  TextFormField(
                    focusNode: _focusNodeConfirmedPassword,
                    controller: _passwordControllerSecond,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,
                      color: _focusNodeConfirmedPassword.hasPrimaryFocus?Colors.black:Colors.grey,
                      ),
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.ispasswordMatched ? "Password Doesn't match" : null;
                    },
                  ),
                  Padding(
                      padding:  EdgeInsets.only(left:Dimensions.safeBlockWidth*10,right:Dimensions.safeBlockWidth*10),
                      child: PasswordValidationIndicator(state:state),
                    ),
                                      
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNodeConfirmedPassword.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    //can make password changed to Passwordchangedfirst but it works so i left
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
    //added this so when password field one is changed it checks for sencond too.
    _registerBloc.add(
      PasswordChangedSecond(password: _passwordController.text,
        password2: _passwordControllerSecond.text),
    );
  }
void _onPasswordChangeSecond(){
    _registerBloc.add(
      PasswordChangedSecond(password: _passwordController.text,
        password2: _passwordControllerSecond.text),
    );
}
  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
