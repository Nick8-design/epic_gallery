import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/model/ImageModel.dart';




class ApiService {


  static const String _pixabayKey = '51145758-8e158aef12b8759c46bcdc835';


  static Future<List<Wallpaper>> fetchWallpapers(String query, int page,
      {int perPage = 20}) async {
    final sources = [
      _fetchFromPixabay(query, page, perPage),


    ];

    for (var source in sources) {
      try {
        final result = await source;
        if (result.isNotEmpty) return result;
      } catch (_) {
        continue;
      }
    }

    throw Exception('All wallpaper sources failed');
  }


  static Future<List<Wallpaper>> _fetchFromPixabay(String query, int page,
      int perPage) async {
    final url = Uri.parse(
        'https://pixabay.com/api/?key=$_pixabayKey&q=$query&image_type=photo&page=$page&per_page=$perPage');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List items = jsonDecode(response.body)['hits'];
      return items.map((item) => Wallpaper.fromPixabay(item)).toList();
    } else {
      throw Exception('Pixabay wallpaper API failed');
    }
  }

}
