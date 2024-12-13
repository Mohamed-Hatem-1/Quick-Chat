import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> RegisterUser(String email, String password) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(message: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(message: 'the account already exist'));
      }
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }

    // @override
    // void onChange(Change<RegisterState> change) {
    //   super.onChange(change);
      
    //   log(change.toString());
    // }
    
  }
}
