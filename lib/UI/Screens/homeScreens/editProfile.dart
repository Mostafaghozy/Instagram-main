import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/logic/editProfile_cubit/cubit.dart';
import 'package:instagram/logic/editProfile_cubit/state.dart';
import 'package:instagram/UI/Widgets/row_text_field.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>(
          create: (context) => EditProfileCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
              ),
              Text('Edit Profile',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
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
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!)) as ImageProvider
                          : const AssetImage('assets/images/dog.png'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Change Profile Photo',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                RowTextField(label: 'Name', value: '', onChanged: (value) {}),
                RowTextField(
                    label: 'Username', value: '', onChanged: (value) {}),
                RowTextField(
                    label: 'Website', value: '', onChanged: (value) {}),
                RowTextField(label: 'Bio', value: '', onChanged: (value) {}),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Switch to Professional Account',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 215),
                  child: Text(
                    "Private Information",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                RowTextField(label: 'Email', value: '', onChanged: (value) {}),
                RowTextField(label: 'Phone', value: '', onChanged: (value) {}),
                RowTextField(label: 'Gender', value: '', onChanged: (value) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
