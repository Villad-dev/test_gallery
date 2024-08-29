import 'package:flutter/material.dart';
import 'package:test_gallery/views/fullscreen_image.dart';

/// A stateless widget that displays an image with its associated metadata (likes and views).
///
/// This widget is used to display a single image item in a grid view. It shows the image
/// from a network source and provides a simple visual representation of the number of likes
/// and views the image has. When the image is tapped, it navigates to a full-screen view of
/// the image.
///
/// The [ImageItem] widget requires an [imageLink] to display the image. Optionally, it can
/// display the number of [likes] and [views] the image has received.
class ImageItem extends StatelessWidget {
  /// The URL link of the image to display.
  final String imageLink;

  /// The number of likes the image has received. This is optional.
  final int? likes;

  /// The number of views the image has received. This is optional.
  final int? views;

  /// Creates an [ImageItem] widget.
  ///
  /// The [imageLink] must not be null. [likes] and [views] could not be passed into constructor
  const ImageItem({super.key, required this.imageLink, this.likes, this.views});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(imageLink: imageLink),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                imageLink,
                fit: BoxFit.contain,
                loadingBuilder: (context, widget, loadingEvent) {
                  if (loadingEvent == null) {
                    return widget;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingEvent.expectedTotalBytes != null
                            ? loadingEvent.cumulativeBytesLoaded /
                            loadingEvent.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye),
                      Text('$views'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      Text('$likes'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
