import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(username.trim());
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(e.message ?? 'Registration failed'));
    } catch (e) {
      emit(RegisterFailure('Registration failed'));
    }
  }
}
