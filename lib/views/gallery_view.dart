import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_gallery/common/gallery_list.dart';
import 'package:test_gallery/common/gallery_search_bar.dart';
import 'package:test_gallery/data/view_models/gallery_view_model.dart';

/// A widget that displays a gallery view with a search bar and a grid of images.
///
/// This widget provides a full-screen view of a gallery with search functionality.
/// It uses the [GalleryViewModel] to manage the state and handle image fetching and searching.
/// The gallery view consists of a search bar at the top and a grid view of images that
/// updates based on the search query.
class GalleryView extends StatelessWidget {
  /// Creates an instance of [GalleryView].
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GalleryViewModel(),
      child: Consumer<GalleryViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 120,
              backgroundColor: Colors.amberAccent,
              actions: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SearchImageBar(
                      searchByQuery: (query) async {
                        viewModel.searchImages(query);
                      },
                    ),
                  ),
                ),
              ],
            ),
            body: FutureBuilder<void>(
              future: fetchInitialData(viewModel),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (viewModel.foundImages == null) {
                  return const Center(child: Text('No images found.'));
                }
                return GridViewList(
                  foundImages: viewModel.foundImages,
                  loadMoreImages: () async {
                    await viewModel.loadMoreImages();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Fetches initial data for the gallery view.
///
/// This function checks if [viewModel.foundImages] is null and if so, it
/// invokes [viewModel.fetchInitialImages] to load the initial set of images.
Future<void> fetchInitialData(GalleryViewModel viewModel) async {
  if (viewModel.foundImages == null) {
    await viewModel.fetchInitialImages();
  }
}
