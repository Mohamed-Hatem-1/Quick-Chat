import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_chat/blocs/auth_bloc/auth_bloc.dart';
import 'package:quick_chat/blocs/my_bloc_observer.dart';
import 'package:quick_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:quick_chat/cubits/login_cubit/login_cubit.dart';
import 'package:quick_chat/cubits/register_cubit/register_cubit.dart';
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
  Bloc.observer = MyBlocObserver();
  runApp(const QuickChat());
}

class QuickChat extends StatelessWidget {
  const QuickChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'LoginPage': (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: 'LoginPage',
      ),
    );
  }
}
