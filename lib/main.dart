import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoopy/screens/chats_screen.dart';
import 'services/search_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen(), // Your ChatScreen widget
      ),
    );
  }
}
