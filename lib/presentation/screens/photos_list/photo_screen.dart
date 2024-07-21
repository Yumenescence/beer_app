import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos_app/data/models/photo.dart';
import 'package:photos_app/data/repositories/photo_repository.dart';
import 'package:photos_app/logic/blocs/photos_bloc.dart';
import 'package:photos_app/logic/events/photo_event.dart';
import 'package:photos_app/logic/states/photo_state.dart';
import 'package:photos_app/presentation/screens/photos_list/widgets/photo_list.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            : const Center(child: Text('List page')),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.clear : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching)
            const Divider(
              thickness: 1,
              height: 1,
            ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocProvider(
              create: (context) => PhotosBloc(PhotosRepository())..add(FetchPhotos()),
              child: BlocBuilder<PhotosBloc, PhotosState>(
                builder: (context, state) {
                  if (state is PhotosLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PhotosLoaded) {
                    final photos = state.photos;
                    final filteredPhotos = _filteredPhotos(photos, _searchController.text);
                    if (filteredPhotos.isEmpty) {
                      return Center(
                        child: Text(
                          'No item found',
                          style: TextStyle(
                              fontSize: 22, color: Theme.of(context).colorScheme.secondary),
                        ),
                      );
                    }
                    return PhotosList(photos: filteredPhotos);
                  } else if (state is PhotosError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Photo> _filteredPhotos(List<Photo> photos, String query) {
    if (query.isEmpty) {
      return photos;
    } else {
      return photos
          .where((photo) => photo.photographer.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
