import 'package:test_gallery/data/models/pixabay_hint.dart';

/// A class representing the search results from the Pixabay API.
///
/// This class encapsulates the information returned from a search query
/// in the Pixabay API. It includes metadata about the search and a list
/// of image hits matching the query.
class PixabaySearch {
  /// The total number of results available for the search query.
  int? total;

  /// The total number of hits (images) returned by the search query.
  int? totalHits;

  /// A list of [Hits] objects representing individual images returned
  /// by the search query.
  List<Hits>? hits;

  /// Creates an instance of [PixabaySearch] with optional named parameters.
  ///
  /// [total] specifies the total number of results available.
  /// [totalHits] specifies the number of hits (images) returned.
  /// [hits] is a list of [Hits] objects representing the images.
  PixabaySearch({this.total, this.totalHits, this.hits});

  /// Creates an instance of [PixabaySearch] from a JSON map.
  ///
  /// The [json] map must contain keys that match the fields in the
  /// [PixabaySearch] class. The [hits] field is parsed as a list of
  /// [Hits] objects.
  PixabaySearch.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalHits = json['totalHits'];
    if (json['hits'] != null) {
      hits = <Hits>[];
      json['hits'].forEach((v) {
        hits!.add(Hits.fromJson(v));
      });
    }
  }

  /// Converts the [PixabaySearch] instance to a JSON map.
  ///
  /// The returned map contains the key-value pairs of all fields in the
  /// [PixabaySearch] class. The [hits] list is serialized as a list of
  /// JSON objects.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['totalHits'] = totalHits;
    if (hits != null) {
      data['hits'] = hits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
