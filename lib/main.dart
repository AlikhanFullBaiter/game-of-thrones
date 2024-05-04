import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab5/firebase_options.dart';
import 'stuff_list_screen.dart'; // Import the StuffListScreen file
import 'actors_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GameOfThronesApp());
}

class GameOfThronesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Thrones',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.redAccent,
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: MainPage(),
      routes: {
        '/stuffList': (context) =>
            StuffListScreen(), // Add route for StuffListScreen
        '/actorsList': (context) =>
            ActorsListScreen(), // Add route for OtherScreen
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game of Thrones'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('List of Stuff'),
              onTap: () {
                Navigator.pushNamed(context, '/stuffList');
              },
            ),
            Divider(), // Add a divider between list items
            ListTile(
              title: Text('List of Actors'),
              onTap: () {
                Navigator.pushNamed(context, '/actorsList');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Image.asset(
                'assets/img/logo.webp',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Game of Thrones App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
