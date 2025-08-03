import 'dart:io';
import 'package:chat_app_flutter/viewmodel/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final provider = Provider.of<UsersProvider>(context, listen: false);
    await provider.loadUserData(uid);

    final userData = provider.user;
    nameController.text = userData['name'] ?? '';
    emailController.text = userData['email'] ?? '';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersProvider>(context);
    final user = provider.user;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Profilni tahrirlash')),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: pickedImage != null
                          ? FileImage(pickedImage!)
                          : (user['image'] != null
                                    ? NetworkImage(user['image'])
                                    : AssetImage(
                                        'https://academy.rudn.ru/static/images/profile_default.png',
                                      ))
                                as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Ism'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await provider.updateUserProfile(
                        uid: uid,
                        name: nameController.text,
                        email: emailController.text,
                        image: pickedImage,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profil yangilandi')),
                      );
                    },
                    child: Text("Saqlash"),
                  ),
                ],
              ),
            ),
    );
  }
}
