import 'package:flutter/material.dart';
import 'package:test_gallery/data/models/delayer.dart';

/// A stateful widget that provides a search bar for querying images.
///
/// The [SearchImageBar] widget displays a text field where users can input
/// a query to search for images. It uses a debouncing mechanism to prevent
/// making frequent API calls as the user types.
///
/// The widget requires a [searchByQuery] function that will be called
/// whenever the user inputs a query, either by typing or submitting.
class SearchImageBar extends StatefulWidget {
  /// Creates a [SearchImageBar].
  ///
  /// The [searchByQuery] parameter must not be null.
  const SearchImageBar({super.key, required this.searchByQuery});

  /// Callback function to execute when a search query is entered.
  ///
  /// This function is called with the search query string when the user
  /// inputs text in the search bar.
  final Future<void> Function(String?) searchByQuery;

  @override
  State<SearchImageBar> createState() => SearchImageBarState();
}

/// State class for [SearchImageBar] that manages the search input and delay logic.
class SearchImageBarState extends State<SearchImageBar> {
  /// Text editing controller for managing the text input in the search bar.
  final TextEditingController controller = TextEditingController();

  /// Delayer to debounce the search function to avoid excessive API calls.
  final Delayer delayer = Delayer(milliseconds: 1000);

  /// Executes the search function with a delay to debounce user input.
  ///
  /// This function is called when the user types or submits a search query.
  /// It uses the [delayer] to prevent making a new search request on every keystroke.
  void searchImageByName(String query) {
    delayer.run(() {
      widget.searchByQuery(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 60,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Find image in PixabayAPI",
            hintStyle: const TextStyle(fontSize: 18),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onChanged: (input) {
            searchImageByName(input);
          },
          onSubmitted: (input) {
            searchImageByName(input);
          },
        ),
      ),
    );
  }
}
