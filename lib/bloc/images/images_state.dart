import '../../models/picsum_image.dart';

abstract class ImagesState {}
class ImagesInitial extends ImagesState {}
class ImagesLoading extends ImagesState {}
class ImagesLoaded extends ImagesState {
  final List<PicsumImage> images;
  ImagesLoaded({required this.images});
}
class ImagesError extends ImagesState {
  final String message;
  ImagesError(this.message);
}
