import 'package:flutter/material.dart';

// Point of Entery of the Flutter application
void main() {
  runApp(MyApp());
}

// Main StatelessWidget of the app
class MyApp extends StatelessWidget {
  // Creating ValueNotifier for theme change
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    // Rebuilding the MaterialApp using ValueListenableBuilder which will listen to changes in _themeMode 
    return ValueListenableBuilder<ThemeMode>(
      // Too listen for changes in theme
      valueListenable: _themeMode, 
      builder: (context, mode, child) {
        return MaterialApp(
          // Setting the light theme for the app
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              // Using it primarily for light theme
              seedColor: Colors.blue, 
              brightness: Brightness.light,
            ),
          ),
          // Setting the dark theme
          darkTheme: ThemeData.dark(),
          // Now setting the theme out of both based on user choice
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          // Declaring the homescreen
          home: HomeScreen(
            // Updating a theme based on button pressing
            onThemeChanged: (ThemeMode newMode) {
              _themeMode.value = newMode;
            },
          ),
        );
      },
    );
  }
}

// StatelessWidget representing HomeScreen
class HomeScreen extends StatelessWidget {
  // A call to function to change theme
  final ValueChanged<ThemeMode> onThemeChanged;

  // Initializing the call using a constructor
  const HomeScreen({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar title
        title: const Text('Theme Demo'), 
      ),
      body: Center(
        child: Column(
          // Using MainAxisAlignment for vertical centre
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            // Text to show
            const Text('Choose your device Theme:'), 
            Row(
              // For evenly spacing out the buttons of themes
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [
                ElevatedButton(
                  // Light theme on pressing light theme
                  onPressed: () => onThemeChanged(ThemeMode.light), 
                  child: const Text('Light Mode'),
                ),
                ElevatedButton(
                  // Now to change it to dark theme
                  onPressed: () => onThemeChanged(ThemeMode.dark), 
                  child: const Text('Dark Mode'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
