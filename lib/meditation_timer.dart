import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MeditationTimerScreen extends StatefulWidget {
  const MeditationTimerScreen({Key? key}) : super(key: key);

  @override
  MeditationTimerScreenState createState() => MeditationTimerScreenState();
}

class MeditationTimerScreenState extends State<MeditationTimerScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _audioPlayer = AudioPlayer();
    _startTimer();
    _startMusic();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    _stopwatch.start();
  }

  void _startMusic() async {
    await _audioPlayer.play('assets/music/background.mp3', isLocal: true);
  }

  void _stopMusic() async {
    await _audioPlayer.stop();
  }

  void _stopTimer() {
    _timer.cancel();
    _stopwatch.stop();
    _stopMusic();
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessão de Meditação'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tempo de meditação: ${_formatElapsedTime(_stopwatch.elapsed)}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _stopTimer();
                  Navigator.pop(context);
                },
                child: const Text('Parar Meditação'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatElapsedTime(Duration elapsed) {
    return elapsed.toString().split('.').first.padLeft(8, "0");
  }
}
