import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/logic/editProfile_cubit/state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

  void updateUsername(String value) {
    emit(state.copyWith(username: value));
  }

  void updateWebsite(String value) {
    emit(state.copyWith(website: value));
  }

  void updateBio(String value) {
    emit(state.copyWith(bio: value));
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updatePhone(String value) {
    emit(state.copyWith(phone: value));
  }

  void updateGender(String value) {
    emit(state.copyWith(gender: value));
  }
}
