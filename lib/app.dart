import 'package:flutter/material.dart';
import 'package:photos_app/presentation/screens/login/login_screen.dart';
import 'package:photos_app/presentation/screens/photos_list/photo_screen.dart';
import 'package:photos_app/theme.dart';

class PhotosApp extends StatelessWidget {
  const PhotosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photos App',
      theme: getLightTheme(),
      home: const LoginScreen(),
      routes: {
        '/main': (context) => PhotosScreen(),
      },
    );
  }
}
