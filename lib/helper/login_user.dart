import 'package:firebase_auth/firebase_auth.dart';

Future<void> LoginUser(String _email, String _password) async {
    
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _email,
      password: _password,
    );
  }