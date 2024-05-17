import 'package:flutter/material.dart';
import 'package:lab5/main.dart';
import 'package:lab5/pages/auth_page.dart';
import 'package:lab5/services/auth_service.dart';

class DividerPage extends StatefulWidget {
  static const route = '/splash-screen';
  const DividerPage({super.key});

  @override
  State<DividerPage> createState() => _DividerPageState();
}

class _DividerPageState extends State<DividerPage> {
  Future checkFirstOpen() async {
    await AuthService().isAuthed().then((authed) {
      if (authed) {
        Navigator.pushReplacementNamed(context, MainPage.route);
      } else {
        Navigator.pushReplacementNamed(context, AuthPage.route);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkFirstOpen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
