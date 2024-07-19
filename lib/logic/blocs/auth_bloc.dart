import 'package:beer_app/data/repositories/auth_repository.dart';
import 'package:beer_app/logic/events/auth_event.dart';
import 'package:beer_app/logic/states/auth_state.dart';
import 'package:beer_app/logic/states/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, BaseState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<ClearErrorStateEvent>(_onClearErrorState);
  }

  void _onLogin(LoginEvent event, Emitter<BaseState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthError(message: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _onClearErrorState(ClearErrorStateEvent event, Emitter<BaseState> emit) {
    emit(AuthInitial());
  }
}
