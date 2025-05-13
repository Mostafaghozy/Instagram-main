import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/logic/editProfile_cubit/cubit.dart';
import 'package:instagram/logic/editProfile_cubit/state.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>(
          create: (context) => EditProfileCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false, // إضافة هذا السطر
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
              const Text('Edit Profile',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Done',
                    style: TextStyle(color: Colors.blue, fontSize: 16)),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              final cubit = context.read<EditProfileCubit>();
              return Column(
                children: [
                  _buildRowTextField(
                      'Name', state.name, (value) => cubit.updateName(value)),
                  _buildRowTextField('Username', state.username,
                      (value) => cubit.updateUsername(value)),
                  _buildRowTextField(
                      'Bio', state.bio, (value) => cubit.updateBio(value)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRowTextField(
      String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label, style: const TextStyle(fontSize: 16))),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: value,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
