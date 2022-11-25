import 'package:flutter/material.dart';
import 'MovieDatabase.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'mainScreens/AccountScreen.dart';
import 'mainScreens/SearchScreen.dart';
import 'mainScreens/homeScreen.dart';

final database = DatabaseProvider();

void main() {
  runApp(
    MaterialApp(
      title: 'Movies App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/account': (context) => const AccountScreen(),
      },
    ),
  );
}















class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
