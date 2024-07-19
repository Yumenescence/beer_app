import 'package:beer_app/logic/blocs/auth_bloc.dart';
import 'package:beer_app/logic/events/auth_event.dart';
import 'package:beer_app/logic/states/auth_state.dart';
import 'package:beer_app/logic/states/base_state.dart';
import 'package:beer_app/presentation/widgets/custom_input_field.dart';
import 'package:beer_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _showEmailError = false;
  bool _showPasswordError = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _emailController.addListener(_onEmailFieldChanged);
    _passwordController.addListener(_onPasswordFieldChanged);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _emailController.removeListener(_onEmailFieldChanged);
    _passwordController.removeListener(_onPasswordFieldChanged);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      if (!_emailFocusNode.hasFocus) {
        _showEmailError = true;
      }
      if (!_passwordFocusNode.hasFocus) {
        _showPasswordError = true;
      }
    });
  }

  void _onEmailFieldChanged() {
    if (_showEmailError && _emailFocusNode.hasFocus) {
      setState(() {
        _showEmailError = false;
      });
      BlocProvider.of<AuthBloc>(context).add(ClearErrorStateEvent());
    }
  }

  void _onPasswordFieldChanged() {
    if (_showPasswordError && _passwordFocusNode.hasFocus) {
      setState(() {
        _showPasswordError = false;
      });
      BlocProvider.of<AuthBloc>(context).add(ClearErrorStateEvent());
    }
  }

  void _onLoginPressed() {
    setState(() {
      _showEmailError = true;
      _showPasswordError = true;
    });
    if (_isValid()) {
      BlocProvider.of<AuthBloc>(context).add(LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  bool _isValid() {
    final emailValid = Validation.validateEmail(_emailController.text);
    final passwordValid = Validation.validatePassword(_passwordController.text);
    return emailValid == null && passwordValid == null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign In',
            style: TextStyle(fontSize: 32, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 72),
          CustomInputField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            hintText: 'Enter your email',
            labelText: 'Email',
            showError: _showEmailError,
            validator: Validation.validateEmail,
          ),
          const SizedBox(height: 32),
          CustomInputField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            hintText: 'Enter your password',
            labelText: 'Password',
            showError: _showPasswordError,
            validator: Validation.validatePassword,
          ),
          const SizedBox(height: 44),
          BlocBuilder<AuthBloc, BaseState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onLoginPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: state is AuthLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white))
                      : Text('Login',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
