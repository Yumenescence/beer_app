import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos_app/data/repositories/photo_repository.dart';
import 'package:photos_app/logic/events/photo_event.dart';
import 'package:photos_app/logic/states/photo_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosRepository photosRepository;

  PhotosBloc(this.photosRepository) : super(PhotosInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
    on<RefreshPhotos>(_onRefreshPhotos);
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<PhotosState> emit) async {
    emit(PhotosLoading());
    try {
      final photos = await photosRepository.fetchPhotos();
      emit(PhotosLoaded(photos));
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }

  Future<void> _onRefreshPhotos(RefreshPhotos event, Emitter<PhotosState> emit) async {
    emit(PhotosLoading());
    try {
      final photos = await photosRepository.fetchPhotos();
      emit(PhotosLoaded(photos));
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }
}
