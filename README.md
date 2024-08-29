# test_gallery

Online gallery using Pixabay API. Test Gallery is a Flutter application that allows users to search and browse images from the Pixabay API. The app displays images in a grid view, supports infinite scrolling, and includes animated loading indicators for a smooth user experience.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An IDE such as VSCode or Android Studio with Flutter and Dart plugins.

### Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Villad-dev/gallery-app.git
   cd gallery-app

2. **Update Dependencies**

Ensure that your pubspec.yaml file includes the following dependencies:

yaml
Copy code
```
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  http: ^1.2.2
  provider: ^6.1.2
  flutter_dotenv: ^5.0.2
```
Run the following command to get the packages:

bash
Copy code
```
flutter pub get
```
## Configure API Key

To use the Pixabay API, you need an API key. Follow these steps to provide your API key:

#### Obtain an API Key:

Sign up at Pixabay to get your API key. Then go to Android Studio configuration of runtime environment (simply additional run args or env args) or in console type command below:

```
--dart-define=API_KEY=your_pixabay_api_key_here
```

## Folder Structure
1 **lib/:** Contains the main source code for the app.

 - ***common/:*** Reusable widgets and components.
 - ***data/:*** Models and data-related classes.
 - ***controller/:*** Contains classes for managing API requests and responses.
 - ***views/:*** Views and screens of the app.
 - ***main.dart:*** Entry point of the application.

## Contributing
- Fork the Repository: Click "Fork" on GitHub.
- Create a Branch: git checkout -b feature/YourFeature
- Commit Changes: git commit -am 'Add new feature'
- Push to Branch: git push origin feature/YourFeature
- Create a Pull Request: Open a pull request to merge your branch into the main branch.
## License
This project is licensed under the MIT License. See the LICENSE file for details.