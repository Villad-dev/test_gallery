import 'package:flutter/material.dart';
import 'package:test_gallery/common/gallery_image_widget.dart';
import 'package:test_gallery/common/loading_circle_animation.dart';
import 'package:test_gallery/data/models/pixabay_search.dart';

/// A stateful widget that displays a grid of images with infinite scrolling and loading animation.
///
/// This widget handles the display of images in a grid format and supports infinite scrolling by
/// loading more images when the user reaches the end of the scrollable area. It also shows a loading
/// animation while new images are being fetched.
///
/// The [GridViewList] widget requires a [foundImages] object of type [PixabaySearch] to display the images.
/// It also requires a [loadMoreImages] callback function that loads more images when called.
class GridViewList extends StatefulWidget {
  /// Creates a [GridViewList] widget.
  ///
  /// The [foundImages] parameter must not be null.
  const GridViewList({
    super.key,
    required this.foundImages,
    required this.loadMoreImages,
  });

  /// The search results containing images to display.
  final PixabaySearch? foundImages;

  /// Callback function to load more images when the user scrolls to the end of the list.
  final Future<void> Function() loadMoreImages;

  @override
  State<GridViewList> createState() => GridViewListState();
}

/// State class for [GridViewList], which manages the state and animation for the grid view.
class GridViewListState extends State<GridViewList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// Controller for scrolling the grid view.
  late final ScrollController scrollController;

  /// Animation controller for managing the loading animation.
  late final AnimationController loadingMoreImagesController;

  /// Animation for sliding in the loading indicator from the bottom.
  late final Animation<Offset> loadingMoreAnimation;

  /// Indicates whether the user has scrolled to the end of the list.
  bool isAtEnd = false;

  /// Controls the visibility of the loading animation.
  bool showAnimation = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (!isAtEnd) {
            setState(() {
              isAtEnd = true;
              showAnimation = true;
            });
            loadingMoreImagesController.forward().then((_) async {
              await widget.loadMoreImages();
              setState(() {
                isAtEnd = false;
                showAnimation = false;
              });
              loadingMoreImagesController.reset();
            });
          }
        }
      });

    loadingMoreImagesController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    loadingMoreAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: loadingMoreImagesController,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    loadingMoreImagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(125, 213, 213, 213),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Search results',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Found images: ${widget.foundImages?.hits?.length ?? 0}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: GridView.builder(
                    key: const PageStorageKey('gridViewKey'),
                    controller: scrollController,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      mainAxisExtent: 200,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2,
                    ),
                    itemCount: widget.foundImages?.hits?.length ?? 0,
                    itemBuilder: (context, itemIndex) {
                      final hit = widget.foundImages?.hits?[itemIndex];
                      return ImageItem(
                        imageLink: hit?.webformatURL ?? 'https://demofree.sirv.com/nope-not-here.jpg',
                        likes: hit?.likes ?? 0,
                        views: hit?.views ?? 0,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showAnimation)
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: loadingMoreAnimation,
              child: LoadingAnimation(
                isLoading: showAnimation,
                animation: loadingMoreAnimation,
              ),
            ),
          ),
      ],
    );
  }
}
