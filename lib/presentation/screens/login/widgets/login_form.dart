import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos_app/logic/blocs/auth_bloc.dart';
import 'package:photos_app/logic/events/auth_event.dart';
import 'package:photos_app/logic/states/auth_state.dart';
import 'package:photos_app/logic/states/base_state.dart';
import 'package:photos_app/presentation/widgets/custom_input_field.dart';
import 'package:photos_app/utils/validation.dart';

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
    _emailFocusNode.addListener(() => _handleFocusChange(_emailFocusNode, 'email'));
    _passwordFocusNode.addListener(() => _handleFocusChange(_passwordFocusNode, 'password'));
    _emailController.addListener(() => _handleFieldChange(_emailFocusNode, 'email'));
    _passwordController.addListener(() => _handleFieldChange(_passwordFocusNode, 'password'));
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(() => _handleFocusChange(_emailFocusNode, 'email'));
    _passwordFocusNode.removeListener(() => _handleFocusChange(_passwordFocusNode, 'password'));
    _emailController.removeListener(() => _handleFieldChange(_emailFocusNode, 'email'));
    _passwordController.removeListener(() => _handleFieldChange(_passwordFocusNode, 'password'));
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleFocusChange(FocusNode focusNode, String field) {
    setState(() {
      if (!focusNode.hasFocus) {
        if (field == 'email') {
          _showEmailError = Validation.validateEmail(_emailController.text) != null;
        } else if (field == 'password') {
          _showPasswordError = Validation.validatePassword(_passwordController.text) != null;
        }
      }
    });
  }

  void _handleFieldChange(FocusNode focusNode, String field) {
    if (field == 'email' && _showEmailError && focusNode.hasFocus) {
      setState(() {
        _showEmailError = false;
      });
      BlocProvider.of<AuthBloc>(context).add(ClearErrorStateEvent());
    } else if (field == 'password' && _showPasswordError && focusNode.hasFocus) {
      setState(() {
        _showPasswordError = false;
      });
      BlocProvider.of<AuthBloc>(context).add(ClearErrorStateEvent());
    }
  }

  void _onLoginPressed() {
    setState(() {
      _showEmailError = Validation.validateEmail(_emailController.text) != null;
      _showPasswordError = Validation.validatePassword(_passwordController.text) != null;
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
      child: BlocBuilder<AuthBloc, BaseState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Column(
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
                enabled: !isLoading,
              ),
              const SizedBox(height: 32),
              CustomInputField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                hintText: 'Enter your password',
                labelText: 'Password',
                showError: _showPasswordError,
                validator: Validation.validatePassword,
                enabled: !isLoading,
              ),
              const SizedBox(height: 44),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _onLoginPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white))
                      : Text('Login',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
