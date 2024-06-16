import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:novo_app_meditacao/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'meditation_timer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Meditação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MeditationHomePage(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}

class MeditationHomePage extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  MeditationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Meditação'),
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
              const Text(
                'Bem-vindo ao App Meditação',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _startMeditationSession(context);
                },
                child: const Text('Iniciar Meditação'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startMeditationSession(BuildContext context) async {
    await analytics.logEvent(
      name: 'iniciar_meditacao',
      parameters: <String, Object>{
        'method': 'button_click',
      },
    );
    debugPrint('Sessão de meditação iniciada.');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MeditationTimerScreen()),
    );
  }
}
