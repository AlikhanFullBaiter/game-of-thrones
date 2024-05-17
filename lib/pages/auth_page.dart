import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab5/main.dart';
import 'package:lab5/pages/forgot_password_page.dart';
import 'package:lab5/services/auth_service.dart';
import 'package:lab5/utils/utils.dart';
import 'package:lab5/widgets/auth_input.dart';
import 'package:lab5/widgets/full_width_button.dart';
import 'package:lab5/widgets/validation.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const String route = 'auth-page';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController? _email;
  TextEditingController? _password;
  TextEditingController? _confirmPassword;

  final _formKey = GlobalKey<FormState>();
  bool isSignIn = true;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email!.dispose();
    _password!.dispose();
    _confirmPassword!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showErrorMessage(String error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error,
        ),
        duration: const Duration(milliseconds: 800),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }

    void showClueMessage(String error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error,
        ),
        duration: const Duration(milliseconds: 800),
        showCloseIcon: true,
        closeIconColor: Colors.amber,
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }

    Future<void> submit() async {
      // try {
      if (_password!.text.isEmpty || _email!.text.isEmpty) {
        return showErrorMessage("Fill an empty fields.");
      }

      if (!isSignIn && _confirmPassword!.text.isEmpty) {
        return showErrorMessage('Fill an empty fields.');
      }

      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(_email!.text.trim())) {
        return showErrorMessage('Invalid Email address!');
      }

      if (_password!.text.trim().length < 6) {
        return showClueMessage('Password should be at least 6 charaters long.');
      }

      if (_password!.text.trim() != _confirmPassword!.text.trim() &&
          !isSignIn) {
        return showErrorMessage('Passwords are not the same.');
      }
      !isSignIn
          ? await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email!.text.trim(),
              password: _password!.text.trim(),
            )
              .then((val) {
              Navigator.of(context).pushReplacementNamed(MainPage.route);
            }).catchError((err) {
              showClueMessage('Provide correct credentials');
            })
          : await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: _email!.text.trim(), password: _password!.text.trim())
              .then((val) {
              Navigator.of(context).pushReplacementNamed(MainPage.route);
            }).catchError((err) {
              showClueMessage('Provide correct credentials');
            });
      // } on FirebaseAuthException catch (e) {
      //   if (!isSignIn) {
      //     if (e.code == 'weak-password' &&
      //         _password!.text.isNotEmpty &&
      //         _confirmPassword!.text.isNotEmpty) {
      //       showClueMessage('The password provided is too weak.');
      //     } else if (e.code == 'email-already-in-use' &&
      //         _email!.text.isNotEmpty) {
      //       showClueMessage('The account already exists for that email.');
      //     }
      //   } else {
      //     if (e.code == 'user-not-found') {
      //       showClueMessage('No user found for that email.');
      //     } else if (e.code == 'wrong-password') {
      //       showClueMessage('Wrong password provided for that user.');
      //     }
      //   }
      // }
    }

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 80,
        ),
        // const AuthLogo(),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            isSignIn ? 'Sign In' : 'Sign Up',
            style: const TextStyle(
                fontFamily: 'PlayFair',
                fontSize: 36,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                AuthInput(
                    controller: _email!,
                    text: 'Email',
                    callback: emailValidation),
                const SizedBox(
                  height: 10,
                ),
                AuthInput(
                  controller: _password!,
                  text: 'Password',
                  callback: passwordValidation,
                  isPassword: true,
                ),
                SizedBox(height: isSignIn ? 0 : 10),
                !isSignIn
                    ? AuthInput(
                        controller: _confirmPassword!,
                        text: 'Confirm Password',
                        callback: confirmPasswordValidation,
                        isPassword: true,
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'forgot password?',
                          style: TextStyle(color: linkColor),
                        ),
                        onPressed: () {
                          setState(() {
                            _email = TextEditingController();
                            _password = TextEditingController();
                            _confirmPassword = TextEditingController();
                          });
                          Navigator.pushNamed(context, ForgotScreen.route);
                        },
                      )
                    ],
                  ),
                ),
                FullWithButton(
                    text: isSignIn ? 'Sign In' : 'Sign Up', callback: submit)
              ]),
            ),
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: 30.0),
        //   child: Image(
        //     image: AssetImage('assets/icons/or_line.png'),
        //     width: 300,
        //     fit: BoxFit.contain,
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () async {
        //     await AuthService().signInWithGoogle(context).whenComplete(() {
        //       Navigator.pushReplacementNamed(context, MainPage.route);
        //     });
        //   },
        //   child: const Image(
        //     image: AssetImage('assets/icons/google_icon.png'),
        //   ),
        // ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              setState(() {
                isSignIn = !isSignIn;
                _email = TextEditingController();
                _password = TextEditingController();
                _confirmPassword = TextEditingController();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member, ',
                  style: TextStyle(
                      color: primeColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  isSignIn ? 'Register here' : 'Login here',
                  style: TextStyle(color: linkColor, fontSize: 15),
                ),
              ],
            ))
      ]),
    )));
  }
}
