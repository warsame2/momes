import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quran_provider.dart';
import 'surah_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuranProvider(),
      child: MaterialApp(
        title: 'حفظ جزء عم',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          cardTheme: CardTheme(
            color: Colors.teal.shade50,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            bodyText2: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        home: const SurahScreen(surahId: '89'),
      ),
    );
  }
}
