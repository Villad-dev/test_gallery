import 'package:flutter/material.dart';
import 'package:test_gallery/controller/http_controller.dart';
import 'package:test_gallery/data/models/pixabay_search.dart';

/// A ViewModel class for managing image gallery data and state.
///
/// The `GalleryViewModel` handles fetching images from the Pixabay API,
/// managing the state of image loading, and notifying listeners about
/// changes in the data. It provides methods to fetch initial images,
/// load more images, and perform searches.
class GalleryViewModel extends ChangeNotifier {
  /// The repository for managing image data.
  final PixabaySearch repository = PixabaySearch();

  /// The HTTP controller for making API requests.
  final HttpController http = HttpController();

  /// The current set of found images.
  PixabaySearch? foundImages;

  /// The current page of results.
  int page = 1;

  /// The current search query.
  String? currentQuery;

  /// Indicates whether data is currently being loaded.
  bool isLoading = false;

  /// Indicates whether there are more images to load.
  bool hasMore = true;

  /// Fetches images from the API based on the provided [query].
  ///
  /// If [query] is not provided, it fetches the initial set of images.
  /// Updates the `foundImages` property with the results and notifies
  /// listeners of any changes.
  Future<void> fetchImages({String? query}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    currentQuery = query;
    page = 1;
    foundImages = null;
    hasMore = true;

    final newImages = await http.fetchImages(page: page, query: query);
    if (newImages != null) {
      foundImages = newImages;
      hasMore = newImages.hits?.isNotEmpty ?? false;
    } else {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Fetches the initial set of images based on the current query.
  ///
  /// This method resets the page to 1 and updates the `foundImages`
  /// property with the results. Notifies listeners of any changes.
  Future<void> fetchInitialImages() async {
    currentQuery = null;
    page = 1;
    final response = await http.fetchImages(query: currentQuery, page: page);
    if (response != null) {
      foundImages = response;
      notifyListeners();
    }
  }

  /// Loads more images by fetching the next page of results.
  ///
  /// This method increments the page number and fetches additional images
  /// from the API. Updates the `foundImages` property with the new images
  /// and notifies listeners of any changes. If no more images are available,
  /// sets `hasMore` to false.
  Future<void> loadMoreImages() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    page++;
    final newImages = await http.fetchImages(page: page, query: currentQuery);
    if (newImages != null) {
      foundImages?.hits?.addAll(newImages.hits ?? []);
      hasMore = newImages.hits?.isNotEmpty ?? false;
    } else {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Searches for images based on the provided [query].
  ///
  /// If the [query] is not null and not empty, it fetches images
  /// corresponding to the query. Updates the `foundImages` property
  /// with the results and notifies listeners of any changes.
  Future<void> searchImages(String? query) async {
    currentQuery = query?.trim().isNotEmpty == true ? query : null;
    page = 1;
    final response = await http.fetchImages(query: currentQuery, page: page);
    if (response != null) {
      foundImages = response;
      notifyListeners();
    }
  }
}
