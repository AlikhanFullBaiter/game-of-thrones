import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future verifyEmail() async {
    String message = '';
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      message = e.code;
    } finally {
      // ignore: control_flow_in_finally
      return message;
    }
  }

  Future<bool> isAuthed() async {
    User? auth = FirebaseAuth.instance.currentUser;
    if (auth != null) {
      return true;
    } else {
      return false;
    }
  }

  Future resetPassword(String email) async {
    String message = '';
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'User is not found.';
      }
    } finally {
      // ignore: control_flow_in_finally
      return message;
    }
  }
}
