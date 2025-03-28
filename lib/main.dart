import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_clutur_streak_system/Domain/service/DatabaseService.dart';
import 'package:urban_clutur_streak_system/Presentation/Home/HomeScreen.dart';
import 'package:urban_clutur_streak_system/Presentation/Streaks/StreaksScreen.dart';
import 'package:urban_clutur_streak_system/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Cultur Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  var bottomNavIndexProvider = StateProvider((ref) => 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            '${ref.watch(bottomNavIndexProvider) == 0 ? 'Daily Skincare' : 'Streaks'}'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: ref.watch(bottomNavIndexProvider),
          onTap: (index) {
            ref.watch(bottomNavIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Routine"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Streaks")
          ]),
      body: [Homescreen(), Streaksscreen()][ref.watch(bottomNavIndexProvider)],
    );
  }
}
