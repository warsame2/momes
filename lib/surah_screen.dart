import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quran_provider.dart';

class SurahScreen extends StatefulWidget {
  final String surahId;

  const SurahScreen({Key? key, required this.surahId}) : super(key: key);

  @override
  _SurahScreenState createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuranProvider>(context, listen: false).loadSurah(widget.surahId);
  }

  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('سورة ${quranProvider.surahName}'),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.repeat),
            onSelected: (value) {
              quranProvider.setRepeatCount(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text('تكرار 1')),
              const PopupMenuItem(value: 3, child: Text('تكرار 3')),
              const PopupMenuItem(value: 5, child: Text('تكرار 5')),
            ],
          ),
        ],
      ),
      body: quranProvider.verses.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: quranProvider.verses.length,
              itemBuilder: (context, index) {
                final verse = quranProvider.verses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      verse['text'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      'الآية ${verse['number']}',
                      textAlign: TextAlign.right,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        quranProvider.setCurrentVerse(verse['text']);
                        quranProvider.playCurrentVerse(verse['audioUrl']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
