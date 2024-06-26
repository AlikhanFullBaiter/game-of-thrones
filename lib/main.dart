import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab5/firebase_options.dart';
import 'package:lab5/pages/auth_page.dart';
import 'package:lab5/pages/calendar_page.dart';
import 'package:lab5/pages/divider_page.dart';
import 'package:lab5/pages/forgot_password_page.dart';
import 'package:lab5/pages/news_list.dart';
import 'package:lab5/services/auth_service.dart';
import 'pages/stuff_list_screen.dart'; // Import the StuffListScreen file
import 'pages/actors_list_screen.dart';

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
      initialRoute: DividerPage.route,
      routes: {
        CalendarScreen.route: (context) => CalendarScreen(),
        DividerPage.route: (context) => DividerPage(),
        AuthPage.route: (context) => AuthPage(),
        MainPage.route: (context) => MainPage(),
        NewsList.route: (context) => NewsList(),
        ForgotScreen.route: (context) => ForgotScreen(),
        '/stuffList': (context) =>
            StuffListScreen(), // Add route for StuffListScreen
        '/actorsList': (context) =>
            ActorsListScreen(), // Add route for OtherScreen
      },
    );
  }
}

class MainPage extends StatelessWidget {
  static const String route = 'main-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game of Thrones'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, DividerPage.route);
              },
              icon: Icon(Icons.logout))
        ],
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
            Divider(), // Add a divider between list items

            ListTile(
              title: Text('Calendar'),
              onTap: () {
                Navigator.pushNamed(context, CalendarScreen.route);
              },
            ),
            Divider(), // Add a divider between list items

            ListTile(
              title: Text('News'),
              onTap: () {
                Navigator.pushNamed(context, NewsList.route);
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
