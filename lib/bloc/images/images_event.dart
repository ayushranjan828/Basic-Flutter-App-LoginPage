abstract class ImagesEvent {}
class FetchImages extends ImagesEvent {
  final int limit;
  FetchImages({this.limit = 10});
}
