/// A class representing an image hit in the Pixabay search results.
///
/// This class is used to parse and serialize information about individual 
/// images returned by the Pixabay API. It includes various details such as
/// image URLs, dimensions, and user information.
class Hits {
  /// The unique identifier for the image.
  int? id;

  /// The URL of the page where the image can be viewed.
  String? pageURL;

  /// The type of the image (e.g., photo, illustration, etc.).
  String? type;

  /// A string of comma-separated tags associated with the image.
  String? tags;

  /// The URL for a preview of the image.
  String? previewURL;

  /// The width of the preview image in pixels.
  int? previewWidth;

  /// The height of the preview image in pixels.
  int? previewHeight;

  /// The URL of the web format of the image.
  String? webformatURL;

  /// The width of the web format image in pixels.
  int? webformatWidth;

  /// The height of the web format image in pixels.
  int? webformatHeight;

  /// The URL of the large image.
  String? largeImageURL;

  /// The width of the large image in pixels.
  int? imageWidth;

  /// The height of the large image in pixels.
  int? imageHeight;

  /// The size of the image file in bytes.
  int? imageSize;

  /// The number of views the image has received.
  int? views;

  /// The number of times the image has been downloaded.
  int? downloads;

  /// The number of collections that include the image.
  int? collections;

  /// The number of likes the image has received.
  int? likes;

  /// The number of comments on the image.
  int? comments;

  /// The unique identifier of the user who uploaded the image.
  int? userId;

  /// The name of the user who uploaded the image.
  String? user;

  /// The URL of the user's profile image.
  String? userImageURL;

  /// Creates an instance of [Hits] with optional named parameters.
  Hits({
    this.id,
    this.pageURL,
    this.type,
    this.tags,
    this.previewURL,
    this.previewWidth,
    this.previewHeight,
    this.webformatURL,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageURL,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.collections,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageURL,
  });

  /// Creates an instance of [Hits] from a JSON map.
  ///
  /// The [json] map must contain keys that match the fields in the [Hits] class.
  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageURL = json['pageURL'];
    type = json['type'];
    tags = json['tags'];
    previewURL = json['previewURL'];
    previewWidth = json['previewWidth'];
    previewHeight = json['previewHeight'];
    webformatURL = json['webformatURL'];
    webformatWidth = json['webformatWidth'];
    webformatHeight = json['webformatHeight'];
    largeImageURL = json['largeImageURL'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    imageSize = json['imageSize'];
    views = json['views'];
    downloads = json['downloads'];
    collections = json['collections'];
    likes = json['likes'];
    comments = json['comments'];
    userId = json['user_id'];
    user = json['user'];
    userImageURL = json['userImageURL'];
  }

  /// Converts the [Hits] instance to a JSON map.
  ///
  /// The returned map contains the key-value pairs of all fields in the 
  /// [Hits] class.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pageURL'] = pageURL;
    data['type'] = type;
    data['tags'] = tags;
    data['previewURL'] = previewURL;
    data['previewWidth'] = previewWidth;
    data['previewHeight'] = previewHeight;
    data['webformatURL'] = webformatURL;
    data['webformatWidth'] = webformatWidth;
    data['webformatHeight'] = webformatHeight;
    data['largeImageURL'] = largeImageURL;
    data['imageWidth'] = imageWidth;
    data['imageHeight'] = imageHeight;
    data['imageSize'] = imageSize;
    data['views'] = views;
    data['downloads'] = downloads;
    data['collections'] = collections;
    data['likes'] = likes;
    data['comments'] = comments;
    data['user_id'] = userId;
    data['user'] = user;
    data['userImageURL'] = userImageURL;
    return data;
  }
}
