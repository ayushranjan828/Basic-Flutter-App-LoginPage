import 'dart:async';
import '../../repositories/picsum_repository.dart';
import 'images_event.dart';
import 'images_state.dart';

class ImagesBloc {
  final PicsumRepository repository;

  ImagesBloc({required this.repository});

  Future<List<dynamic>> fetch(int limit) async {
    return await repository.fetchImages(limit: limit);
  }
}
