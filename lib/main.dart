
import 'package:aagilocano1/features/app/splash_screen/splash_screen.dart';
import 'package:aagilocano1/features/pages/home/practice_menu.dart';
import 'package:aagilocano1/features/pages/home/profile_page.dart';
import 'package:aagilocano1/features/pages/home/quiz_menu.dart';
import 'package:aagilocano1/features/pages/home/story_menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'features/pages/login/login_page.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ammo Ag-Ilocano?',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff39f1d0)),
        useMaterial3: true,
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xff39f1d0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
              return Colors.teal;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
              return const Color(0xffffffff);
            }),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff39f1d0), selectedItemColor: Colors.green, type: BottomNavigationBarType.fixed),
        appBarTheme: AppBarTheme(foregroundColor: Colors.white, backgroundColor: const Color(0xff39f1d0), centerTitle: true,titleTextStyle: GoogleFonts.inter(textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30))),
        textTheme: GoogleFonts.getTextTheme("Open Sans", const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xffacece0),
          ),
        )),
      ),
      routes: {
        '/': (context) => const SplashScreen(
          child: LoginPage(),
        ),
        '/login': (context) => const SplashScreen(
          child: LoginPage(),
        ),
        '/profile': (context) => const ProfilePage(),
        '/quiz_menu': (context) => const QuizMenu(),
        '/story_menu': (context) => const StoryMenu(),
        '/practice_menu': (context) => const PracticeMenu(),
      }
    );
  }
}
