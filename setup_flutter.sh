#!/bin/bash

echo "🚀 Setting up KittyPaws Flutter Project with Clean Architecture & BLoC Pattern..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first:"
    echo "   https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter version
echo "📱 Flutter version: $(flutter --version | head -n 1)"

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Check for any issues
echo "🔍 Checking for Flutter issues..."
flutter doctor

# Create necessary directories if they don't exist
echo "📁 Creating project structure..."
mkdir -p android/app/src/main/kotlin/com/example/kittypaws
mkdir -p ios/Runner

echo "✅ KittyPaws Flutter project with Clean Architecture setup complete!"
echo ""
echo "To run the app:"
echo "  flutter run"
echo ""
echo "To build for Android:"
echo "  flutter build apk --release"
echo ""
echo "To build for iOS:"
echo "  flutter build ios --release"
echo ""
echo "Happy coding! 🐾"
