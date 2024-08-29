import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_gallery/data/const/constant_values.dart';
import 'package:test_gallery/data/models/pixabay_search.dart';

/// A controller class that handles HTTP requests for fetching images from the Pixabay API.
class HttpController {
  /// Sends an HTTP GET request to the specified [url] and returns the response body as a string.
  ///
  /// Throws an [Exception] if the request fails or if the response status code is not 200.
  ///
  /// Example:
  /// ```dart
  /// final response = await httpGetRequest('https://example.com/api');
  /// ```
  ///
  /// [url]: The URL to send the HTTP GET request to.
  Future<String> httpGetRequest(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get data; Code: ${response.statusCode}');
    }
  }

  /// Fetches images from the Pixabay API based on the provided [page] number and optional [query].
  ///
  /// Returns a [PixabaySearch] object if the request is successful and the response body is not empty.
  /// Returns `null` if the response is empty.
  ///
  /// Example:
  /// ```dart
  /// final images = await fetchImages(page: 1, query: 'cats');
  /// ```
  ///
  /// [page]: The page number for paginated results.
  /// [query]: An optional search query to filter images.
  Future<PixabaySearch?> fetchImages({required int page, String? query}) async {
    String queryParam = '';
    if (query != null && query.isNotEmpty) {
      queryParam = '&q=${Uri.encodeComponent(query)}';
    }
    final response = await httpGetRequest('$pixabayImages&page=$page$queryParam');
    if (response.isNotEmpty) {
      return PixabaySearch.fromJson(jsonDecode(response));
    }
    return null;
  }
}
