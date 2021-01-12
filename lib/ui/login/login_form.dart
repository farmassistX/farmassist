import 'package:farmassist/app_theme.dart';
import 'package:farmassist/bloc/login/login_cubit.dart';
import 'package:farmassist/ui/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/app_icon.png',
                height: 120,
              ),
              const SizedBox(height: 18.0),
              _EmailInput(),
              const SizedBox(height: 12.0),
              _PasswordInput(),
              const SizedBox(height: 12.0),
              _LoginButton(),
              const SizedBox(height: 24.0),
              _SignUpButton(),
              const SizedBox(height: 24.0),
              _GoogleLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          width: 300,
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'Invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: 300,
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_rounded),
              labelText: 'Password',
              helperText: '',
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 45,
                width: 200,
                child: RaisedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  child: const Text('LOG IN', style: AppTheme.bodyText1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: const Color(0xFFFFD600),
                  onPressed: () =>
                    context.read<LoginCubit>().logInWithCredentials(),
                ),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 200,
      child: RaisedButton(
        key: const Key('loginForm_createAccount_flatButton'),
        child: const Text('CREATE ACCOUNT', style: AppTheme.bodyText1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: const Color(0xFFFFD600),
        onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 200,
      child: FlatButton(
        key: const Key('loginForm_googleLogin_raisedButton'),
        padding: EdgeInsets.all(0.0),
        child: Image.asset(
          'assets/images/btn_google_signin.png',
          scale: 1.85,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: AppTheme.white,
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      ),
    );
  }
}
