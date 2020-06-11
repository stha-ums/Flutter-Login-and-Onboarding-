import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'passwordreset.dart';

class PasswordResetForm extends StatefulWidget {
  State<PasswordResetForm> createState() => _PasswordResetForm();
}

class _PasswordResetForm extends State<PasswordResetForm> {
  PasswordresetBloc _passwordresetBloc;
  final TextEditingController _emailController = TextEditingController();


  bool get isPopulated =>
      _emailController.text.isNotEmpty ;

  bool isResetButtonEnabled(PasswordresetState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _passwordresetBloc = BlocProvider.of<PasswordresetBloc>(context);
    _emailController.addListener(_onEmailChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordresetBloc, PasswordresetState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sending email ...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('email with password reset link has been sent'),
                    Icon(Icons.done),
                  ],
                ),
                backgroundColor: Colors.green,
              )
            );
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
      child: BlocBuilder<PasswordresetBloc, PasswordresetState>(
        builder: (context, state) {
          return 
            Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  PasswordresetButton(
                    onPressed: isResetButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _passwordresetBloc.add(
      EmailChangedReset(email: _emailController.text),
    );
  }

  void _onFormSubmitted() {
    _passwordresetBloc.add(
      Submitted(
        email: _emailController.text,
      ),
    );
  }
}
