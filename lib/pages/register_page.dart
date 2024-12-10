import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_chat/constants.dart';
import 'package:quick_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:quick_chat/cubits/register_cubit/register_cubit.dart';
import 'package:quick_chat/helper/show_snack_bar.dart';
import 'package:quick_chat/pages/chat_page.dart';
import 'package:quick_chat/widgets/button_widget.dart';
import 'package:quick_chat/widgets/textformfield_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';

  bool _isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          _isloading = true;
        } else if (state is RegisterSuccess) {
          showSnackBar(context, 'Registered Successfully', c: Colors.green);
          BlocProvider.of<ChatCubit>(context).getMessages();
          // Navigator.pushReplacementNamed(
          //   context,
          //   ChatPage.id,
          //   arguments: email,
          // );
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          _isloading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.message);
          _isloading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          'Register',
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
                      text: 'Register',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .RegisterUser(email, password);
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
                          'already have an account?  ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
