import 'package:flutter/material.dart';

/// A full-screen image viewer widget.
///
/// Displays an image in full-screen mode with a close button to
/// dismiss the view. The image is animated with a hero transition
/// to provide a smooth visual effect when navigating from the
/// thumbnail view to the full-screen view.
class FullScreenImage extends StatelessWidget {
  /// Creates an instance of [FullScreenImage].
  ///
  /// Requires [imageLink] to display the image.
  ///
  /// [imageLink] must not be null.
  const FullScreenImage({super.key, required this.imageLink});

  /// The URL of the image to be displayed in full-screen mode.
  ///
  /// This URL must point to a valid image resource.
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: imageLink,
              child: Image.network(
                imageLink,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
