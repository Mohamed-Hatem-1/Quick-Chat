import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_chat/constants.dart';
import 'package:quick_chat/helper/register_user.dart';
import 'package:quick_chat/helper/show_snack_bar.dart';
import 'package:quick_chat/pages/chat_page.dart';
import 'package:quick_chat/widgets/button_widget.dart';
import 'package:quick_chat/widgets/textformfield_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'RegisterPage';

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                Image.asset(kLogo),
                Row(
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
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        _isloading = true;
                      });
                      try {
                        await RegisterUser(email, password);
                        showSnackBar(context, 'Registered Successfully',
                            c: Colors.green);
                        Navigator.pushNamed(context, ChatPage.id, arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'Weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'the account already exist');
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
                      'already have an account?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
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
