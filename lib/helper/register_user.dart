import 'package:firebase_auth/firebase_auth.dart';

Future<void> RegisterUser(String _email, String _password) async {
    
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
  }