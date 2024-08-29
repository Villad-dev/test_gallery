/// The API key used for authenticating requests to the Pixabay API.
/// 
/// This key is injected at compile time using the `--dart-define` parameter. 
/// It should be kept secret and not exposed in the source code directly.
/// 
/// Example usage in a Dart build configuration:
/// ```bash
/// flutter build apk --dart-define=API_KEY=your_api_key_here
/// ```
const String pixabayAPIKEY = String.fromEnvironment('API_KEY');

/// The base URL for the Pixabay API endpoint.
const String pixabayEntryLink = 'https://pixabay.com/api/';

/// The full URL for accessing image data from the Pixabay API, including the API key.
/// 
/// This URL is constructed by combining the base URL with the API key.
/// It is used to make requests for fetching images from the Pixabay API.
const String pixabayImages = '$pixabayEntryLink?key=$pixabayAPIKEY';
