# 🚀 Quick Start Guide

Get OpenFlix running on your machine in just a few steps!

## Prerequisites

Ensure you have Flutter installed:
```bash
flutter doctor
```

## Installation & Running

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   
   For Android/iOS:
   ```bash
   flutter run
   ```

   For Web:
   ```bash
   flutter run -d chrome
   ```

   For specific device:
   ```bash
   flutter devices  # List available devices
   flutter run -d <device-id>
   ```

## First Launch

When you first launch the app:
1. The home screen will automatically load popular movies
2. Use the search icon (top right) to search for specific movies
3. Tap any movie poster to view detailed information
4. Enjoy browsing!

## Common Commands

### Clean Build
```bash
flutter clean
flutter pub get
flutter run
```

### Check for Issues
```bash
flutter doctor -v
flutter analyze
```

### Hot Reload
While app is running, press `r` in terminal to hot reload

### Hot Restart
While app is running, press `R` in terminal to hot restart

## Project Features Breakdown

### 🎯 State Management with Bloc
All state is managed through the `MovieBloc`:
- **Events**: User actions (search, load movies, etc.)
- **States**: UI states (loading, loaded, error)
- **Bloc**: Business logic connecting events to states

### 🎬 OMDB API Integration
The app connects to OMDB API to fetch:
- Popular movies and series
- Search results
- Detailed movie information
- Ratings and reviews

### 📱 Beautiful UI
- Netflix-inspired design
- Smooth scrolling
- Image caching for performance
- Responsive layout

## Troubleshooting

### Issue: Packages not found
```bash
flutter clean
flutter pub get
```

### Issue: Internet connection error
- Check your internet connection
- The app requires internet to fetch movie data
- Ensure your device/emulator has network access

### Issue: Images not loading
- Images require internet connection
- Some movie posters may not be available in OMDB
- The app shows a placeholder for unavailable images

## Next Steps

1. ✅ Explore the codebase structure
2. ✅ Modify colors in `lib/main.dart`
3. ✅ Add more movie categories in `lib/services/omdb_service.dart`
4. ✅ Customize widgets in `lib/widgets/`
5. ✅ Extend Bloc functionality in `lib/bloc/`

## Development Tips

- Use `flutter run --release` for better performance
- Enable hot reload for faster development
- Check `flutter logs` for debugging
- Use Flutter DevTools for advanced debugging

## Support

For more details, check the main [README.md](README.md)

---

Happy coding! 🎬🍿



