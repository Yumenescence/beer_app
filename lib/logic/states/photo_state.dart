import 'package:equatable/equatable.dart';
import 'package:photos_app/data/models/photo.dart';

abstract class PhotosState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photo> photos;

  PhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class PhotosError extends PhotosState {
  final String message;

  PhotosError(this.message);

  @override
  List<Object> get props => [message];
}
