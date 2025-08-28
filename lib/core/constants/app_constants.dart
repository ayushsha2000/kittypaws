class AppConstants {
  // App Info
  static const String appName = 'KittyPaws';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String redditBaseUrl = 'https://api.reddit.com';
  static const String userAgent = 'KittyPaws/1.0.0';
  
  // Subreddits
  static const List<String> catSubreddits = [
    'IllegallySmolCats',
    'cats',
    'chonkers',
    'Catloaf',
    'tuckedinkitties',
  ];
  
  static const List<String> dogSubreddits = [
    'puppies',
    'Cutedogsreddit',
    'IllegallySmolDogs',
    'rarepuppers',
    'dogpictures',
  ];
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // Sizes
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 8.0;
  
  // Colors
  static const int primaryColorLight = 0xFF6200EE;
  static const int primaryColorDark = 0xFFBB86FC;
  static const int accentColorLight = 0xFF03DAC6;
  static const int accentColorDark = 0xFF03DAC6;
}
