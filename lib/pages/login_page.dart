import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quick_chat/blocs/auth_bloc/auth_bloc.dart';
import 'package:quick_chat/constants.dart';
import 'package:quick_chat/cubits/chat_cubit/chat_cubit.dart';
// import 'package:quick_chat/cubits/login_cubit/login_cubit.dart';
import 'package:quick_chat/helper/show_snack_bar.dart';
import 'package:quick_chat/pages/chat_page.dart';
import 'package:quick_chat/pages/register_page.dart';
import 'package:quick_chat/widgets/button_widget.dart';
import 'package:quick_chat/widgets/textformfield_widget.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  bool _isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          _isloading = true;
        } else if (state is LoginSuccess) {
          showSnackBar(context, 'Logged in Successfully', c: Colors.green);
          BlocProvider.of<ChatCubit>(context).getMessages();
          // Navigator.pushReplacementNamed(
          //   context,
          //   ChatPage.id,
          //   arguments: email,
          // );
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          _isloading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.message);
          _isloading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: _isloading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 400,
                    child: Image.asset(
                      kLogo,
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextformfieldWidget(
                    hint: 'Email',
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextformfieldWidget(
                    obsecureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    hint: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email, password: password));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account?  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
