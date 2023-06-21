import 'package:dan_notes_saver/add_update_screen.dart';
import 'package:dan_notes_saver/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
initialRoute: '/homeScreen',
      routes: {
        '/addUpdate' : (context) => AddUpdateTask(),
        '/homeScreen' :(context) => HomeScreen(),
      },

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DAN_Notes_'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      )
    ,body: HomeScreen(),)  ;

  }
}
