import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(message: 'No user found for that email'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(message: 'Wrong Password'));
          } else if (e.code == 'invalid-email') {
            emit(LoginFailure(message: 'The email address is not valid'));
          } else if (e.code == 'too-many-requests') {
            emit(LoginFailure(
                message: 'Too many login attempts, Please try again later'));
          } else if (e.code == 'network-request-failed') {
            emit(LoginFailure(
                message: 'Network error. Please check your connection.'));
          } else {
            emit(LoginFailure(message: 'Login failed: ${e.message}'));
          }
        } catch (e) {
          emit(LoginFailure(message: e.toString()));
        }

        // @override
        // void onTransition(Transition<AuthEvent, AuthState> transition) {
        //   super.onTransition(transition);

        //   log(transition.toString());
        // }
      }
    });
  }
}
