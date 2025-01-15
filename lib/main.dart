import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('مشروع حفظ القرآن'),
        ),
        body: QuranAudioPlayer(),
      ),
    );
  }
}

class QuranAudioPlayer extends StatefulWidget {
  @override
  _QuranAudioPlayerState createState() => _QuranAudioPlayerState();
}

class _QuranAudioPlayerState extends State<QuranAudioPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void _playAudio(String url) async {
    if (isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _playAudio('assets/audio/audio1.mp3');
            },
            child: Text(isPlaying ? 'إيقاف' : 'تشغيل'),
          ),
        ],
      ),
    );
  }
}
