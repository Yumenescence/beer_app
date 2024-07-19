import 'package:beer_app/presentation/screens/login_screen.dart';
import 'package:beer_app/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getLightTheme(),
      home: const LoginScreen(),
      routes: {
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the main screen!'),
      ),
    );
  }
}
