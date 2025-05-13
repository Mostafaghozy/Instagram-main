import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  final String name;
  final String username;
  final String website;
  final String bio;
  final String email;
  final String phone;
  final String gender;

  const EditProfileState({
    this.name = '',
    this.username = '',
    this.website = '',
    this.bio = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
  });

  EditProfileState copyWith({
    String? name,
    String? username,
    String? website,
    String? bio,
    String? email,
    String? phone,
    String? gender,
  }) {
    return EditProfileState(
      name: name ?? this.name,
      username: username ?? this.username,
      website: website ?? this.website,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props =>
      [name, username, website, bio, email, phone, gender];
}
