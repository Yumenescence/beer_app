abstract class BaseState {}

class LoadingState extends BaseState {}

class ErrorState extends BaseState {
  final String message;

  ErrorState({required this.message});
}

class EmptyState extends BaseState {}

class DataState<T> extends BaseState {
  final T data;

  DataState({required this.data});
}
