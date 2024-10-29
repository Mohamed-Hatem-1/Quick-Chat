import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quick_chat/constants.dart';
import 'package:quick_chat/helper/login_user.dart';
import 'package:quick_chat/helper/show_snack_bar.dart';
import 'package:quick_chat/pages/chat_page.dart';
import 'package:quick_chat/pages/register_page.dart';
import 'package:quick_chat/widgets/button_widget.dart';
import 'package:quick_chat/widgets/textformfield_widget.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  late String email, password;

  @override
  Widget build(BuildContext context) {
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
                Image.asset(
                  kLogo,
                ),
                Row(
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
                SizedBox(height: 20),
                TextformfieldWidget(
                  hint: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextformfieldWidget(
                  obsecureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  hint: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        _isloading = true;
                      });
                      try {
                        await LoginUser(email, password);
                        showSnackBar(context, 'Logged in Successfully',
                            c: Colors.green);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong Password');
                        } else if (e.code == 'invalid-email') {
                          showSnackBar(
                              context, 'The email address is not valid');
                        } else if (e.code == 'too-many-requests') {
                          showSnackBar(context,
                              'Too many login attempts. Please try again later.');
                        } else if (e.code == 'network-request-failed') {
                          showSnackBar(context,
                              'Network error. Please check your connection.');
                        } else {
                          showSnackBar(context, 'Login failed: ${e.message}');
                        }
                      } catch (e) {
                        showSnackBar(
                            context, 'An error occurred: ${e.toString()}');
                      } finally {
                        setState(() {
                          _isloading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
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
    );
  }
}
