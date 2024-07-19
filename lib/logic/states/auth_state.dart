import 'package:beer_app/data/models/user.dart';

import 'base_state.dart';

class AuthState extends BaseState {}

class AuthInitial extends AuthState {}

class AuthLoading extends LoadingState {}

class AuthAuthenticated extends DataState<User> {
  AuthAuthenticated({required User user}) : super(data: user);
}

class AuthError extends ErrorState {
  AuthError({required super.message});
}

class AuthEmpty extends EmptyState {}
