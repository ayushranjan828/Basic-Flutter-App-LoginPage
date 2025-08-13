import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/picsum_image.dart';

class PicsumRepository {
  final String _base = 'https://picsum.photos';

  Future<List<PicsumImage>> fetchImages({int limit = 10}) async {
    final uri = Uri.parse('$_base/v2/list?limit=$limit');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final list = json.decode(res.body) as List;
      return list.map((e) => PicsumImage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load images: ${res.statusCode}');
    }
  }
}
