import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos_app/data/models/photo.dart';
import 'package:photos_app/logic/blocs/photos_bloc.dart';
import 'package:photos_app/logic/events/photo_event.dart';
import 'package:photos_app/presentation/screens/photos_list/widgets/photo_item.dart';

class PhotosList extends StatefulWidget {
  final List<Photo> photos;

  const PhotosList({super.key, required this.photos});

  @override
  State<PhotosList> createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _refreshPhotos() async {
    BlocProvider.of<PhotosBloc>(context).add(FetchPhotos());
  }

  @override
  Widget build(BuildContext context) {
    final groupedPhotos = _groupPhotosByName(widget.photos);
    final sortedKeys = groupedPhotos.keys.toList()..sort();

    return RefreshIndicator(
      onRefresh: _refreshPhotos,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            cacheExtent: 10000,
            controller: _scrollController,
            itemCount: sortedKeys.length,
            itemBuilder: (context, index) {
              final key = sortedKeys[index];
              final group = groupedPhotos[key]!;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        key,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: group.map((photo) => PhotoItem(photo: photo)).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Map<String, List<Photo>> _groupPhotosByName(List<Photo> photos) {
    final Map<String, List<Photo>> groupedPhotos = {};
    for (var photo in photos) {
      final firstLetter = photo.photographer[0].toUpperCase();
      if (!groupedPhotos.containsKey(firstLetter)) {
        groupedPhotos[firstLetter] = [];
      }
      groupedPhotos[firstLetter]!.add(photo);
    }
    return groupedPhotos;
  }
}
