import 'package:flutter/material.dart';
import 'package:quick_chat/pages/chat_page.dart';
import 'package:quick_chat/pages/login_page.dart';
import 'package:quick_chat/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const QuickChat());
}

class QuickChat extends StatelessWidget {
  const QuickChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginPage': (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: 'LoginPage',
    );
  }
}
