import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globals.dart';
import 'stararchive/saselection.dart';
import 'stararchive/createstar.dart';
import 'explorium/exselection.dart';
import 'explorium/exresults.dart';
import 'planetarium/plselection.dart';
import 'skycalendar/scselection.dart';
import 'deepsky/dsselection.dart';
import 'spacequiz/sqselection.dart';
import 'spacequiz/quizpage.dart';
import 'results/results.dart';
import 'about/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astro Quest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: txtColor),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/stararchive': (context) => const StarArchive(),
        '/createstar': (context) => const CreateStar(),
        '/explorium': (context) => const Explorium(),
        '/exresult': (context) => const ExpResult(),
        '/planetarium': (context) => const Planetarium(),
        '/skycalendar': (context) => const SkyCalendar(),
        '/deepsky': (context) => const DeepSky(),
        '/spacequiz': (context) => const SpaceQuiz(),
        '/quizscreen': (context) => const QuizScreen(),
        '/result': (context) => const ResultPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    SizedBox routeButton(String route, String txt, IconData icon) {
      double y = 0.12;
      return SizedBox(
        height: screenHeight * y,
        child: ElevatedButton(
          style: btnStyle,
          onPressed: () {Navigator.pushNamed(context, route);},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, size: 30),
              Text(
                txt,
                style: const TextStyle(fontSize: 26),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 28,
              ),
            ],
          ),
        ),
      );
    }

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black38,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text('Astro Quest'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {Navigator.pushNamed(context, '/about');},
              ),],
          ),
          body: ListView(
            padding: EdgeInsets.all(padding),
                children: <Widget>[
                  routeButton('/stararchive', 'Star Archive', Icons.folder_special),
                  spacing(),
                  routeButton('/explorium', 'Explorium', Icons.web_stories),
                  spacing(),
                  routeButton('/planetarium', 'Planetarium', Icons.public),
                  spacing(),
                  routeButton('/deepsky', 'Sky Catalogs', Icons.library_books),
                  spacing(),
                  routeButton('/skycalendar', 'Sky Calendar', Icons.calendar_month),
                  spacing(),
                  routeButton('/spacequiz', 'Space Quizzer', Icons.quiz),
                ],),
              ),
            );
  }
}
