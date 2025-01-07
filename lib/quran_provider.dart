import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class QuranProvider extends ChangeNotifier {
  String _currentVerse = 'اضغط على الآية لتشغيلها';
  int _repeatCount = 1;
  List<Map<String, dynamic>> _verses = [];
  String _surahName = 'الفجر';
  final AudioPlayer _audioPlayer = AudioPlayer();

  String get currentVerse => _currentVerse;
  String get surahName => _surahName;
  List<Map<String, dynamic>> get verses => _verses;

  Future<void> loadSurah(String surahId) async {
    final String response = await rootBundle.loadString('assets/quran.json');
    final data = json.decode(response);
    final surah = data[surahId];
    _surahName = surah['name'];
    _verses = List<Map<String, dynamic>>.from(surah['verses']);
    notifyListeners();
  }

  void setCurrentVerse(String verse) {
    _currentVerse = verse;
    notifyListeners();
  }

  Future<void> playCurrentVerse(String audioUrl) async {
    for (int i = 0; i < _repeatCount; i++) {
      await _audioPlayer.play(UrlSource(audioUrl));
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  void stopAudio() {
    _audioPlayer.stop();
  }

  void setRepeatCount(int count) {
    _repeatCount = count;
    notifyListeners();
  }
}
