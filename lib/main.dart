import 'package:firebase_core/firebase_core.dart';
import 'package:testing/breathe/breathe.dart';
import 'package:testing/home/home.dart';
import 'package:testing/journal/journal.dart';
import 'package:testing/log/log.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathe',
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => HomeScreen(),
        '/breathe': (BuildContext context) => BreatheScreen(),
        '/log': (BuildContext context) => LogPage(),
        '/view_journal' : (BuildContext context) => JournalEntryPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',  // Set the initial route to '/home'
    );
  }
}