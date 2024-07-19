abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  List<Object> get props => [email, password];
}

class ClearErrorStateEvent extends AuthEvent {
  List<Object?> get props => [];
}
