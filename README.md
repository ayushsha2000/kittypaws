# 🐱 KittyPaws - Flutter App

A beautiful Flutter application for pet lovers that displays cat and dog content from Reddit APIs. Built with **Clean Architecture**, **BLoC Pattern**, and **Material Design 3**.

## ✨ Features

- 🏠 **Animated Home Screen**: Beautiful gradient backgrounds with smooth animations
- 🐱 **Cats Screen**: Fetches and displays cat content from multiple Reddit subreddits
- 🐶 **Dogs Screen**: Fetches and displays dog content from multiple Reddit subreddits
- 🌙 **Dynamic Theme System**: Smooth transitions between light and dark themes
- 📱 **Responsive Design**: Optimized for both mobile and tablet devices
- 🔄 **Pull to Refresh**: Refresh content on cats and dogs screens
- 🎥 **Enhanced Video Support**: Custom video controls with play/pause
- 🖼️ **Advanced Image Handling**: Full-screen image viewer with zoom capabilities
- ✨ **Smooth Animations**: Fade, slide, and scale animations throughout the app
- 🎨 **Material Design 3**: Modern UI with Google's latest design principles

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── core/                          # Core functionality
│   ├── blocs/                     # BLoC pattern implementation
│   │   ├── theme/                 # Theme state management
│   │   └── posts/                 # Posts state management
│   ├── constants/                 # App constants and configuration
│   └── theme/                     # App theme system
├── data/                          # Data layer
│   └── repositories/              # Repository implementations
├── domain/                        # Domain layer
│   ├── entities/                  # Business entities
│   └── repositories/              # Repository interfaces
├── screens/                       # Presentation layer
│   ├── home_screen.dart           # Animated home screen
│   ├── cats_screen.dart           # Cats content screen
│   └── dogs_screen.dart           # Dogs content screen
└── widgets/                       # Reusable UI components
    └── post_card.dart             # Enhanced post display widget
```

### BLoC Pattern Implementation

- **ThemeBloc**: Manages app theme state (light/dark mode)
- **PostsBloc**: Manages Reddit posts data and loading states
- **Event-driven architecture** for clean state management
- **Separation of concerns** between UI and business logic

## 🛠️ Dependencies

### State Management
- **flutter_bloc**: BLoC pattern implementation
- **equatable**: Value equality for clean state comparisons

### Network & Data
- **http**: HTTP requests for Reddit APIs
- **dio**: Advanced HTTP client (alternative)
- **json_annotation**: JSON serialization support

### UI & Design
- **google_fonts**: Beautiful typography with Poppins font
- **flutter_svg**: SVG support for scalable graphics
- **shimmer**: Loading placeholders with shimmer effect
- **lottie**: High-quality animations

### Media
- **video_player**: Enhanced video playback
- **cached_network_image**: Efficient image loading and caching
- **photo_view**: Full-screen image viewer with zoom

### Storage
- **shared_preferences**: Local storage for theme preferences
- **hive**: Fast local database (alternative)

### Utils
- **intl**: Internationalization and date formatting
- **url_launcher**: External link handling
- **permission_handler**: Device permissions management

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd kittypaws
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Setup with script**
   ```bash
   ./setup_flutter.sh
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS IPA:**
```bash
flutter build ios --release
```

## 🔌 API Integration

The app integrates with Reddit's JSON API to fetch content from:

### Cats Content
- r/IllegallySmolCats
- r/cats
- r/chonkers
- r/Catloaf
- r/tuckedinkitties

### Dogs Content
- r/puppies
- r/Cutedogsreddit
- r/IllegallySmolDogs
- r/rarepuppers
- r/dogpictures

## 🎨 Theme System

### Material Design 3
- **Dynamic color system** with seed colors
- **Adaptive themes** for light and dark modes
- **Smooth transitions** between theme changes
- **Custom color schemes** for brand consistency

### Animation System
- **Fade animations** for smooth page transitions
- **Slide animations** for content reveals
- **Scale animations** for interactive elements
- **Hero animations** for image transitions

## 📱 UI Components

### Enhanced Post Cards
- **Expandable content** with smooth animations
- **Video controls** with custom play/pause buttons
- **Image zoom** with full-screen viewer
- **Rich metadata** display (author, score, comments)
- **Shimmer loading** states

### Navigation
- **Gradient buttons** with Material Design 3
- **Smooth page transitions** with custom animations
- **Back navigation** with animated headers

## 🔧 Development

### Code Generation
```bash
# Generate JSON serialization code
flutter packages pub run build_runner build

# Generate Hive adapters (if using Hive)
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart
```

## 📊 Performance Features

- **Lazy Loading**: Content loads as needed
- **Image Caching**: Reduces network requests
- **Efficient Lists**: Uses ListView.builder for large datasets
- **Memory Management**: Proper disposal of controllers and animations
- **Optimized Animations**: Hardware-accelerated animations

## 🌐 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 11.0+)
- ✅ Web (experimental)
- ✅ Desktop (experimental)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow **Clean Architecture** principles
- Use **BLoC pattern** for state management
- Implement **Material Design 3** guidelines
- Add **smooth animations** for better UX
- Write **comprehensive tests** for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Reddit API** for providing content
- **Flutter team** for the amazing framework
- **BLoC pattern** creators for state management
- **Material Design team** for design guidelines
- **Original React Native project** contributors

## 📞 Support

For support and questions:
- Open an issue on the repository
- Check the [Flutter documentation](https://flutter.dev/docs)
- Review [BLoC documentation](https://bloclibrary.dev)

---

**Made with ❤️ and Flutter**
