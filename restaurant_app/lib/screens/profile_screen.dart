import 'package:flutter/material.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/services/firebase_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static final path = "/profile";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final data = await FirebaseService.instance.getUserProfile();
    if (!mounted) return;
    setState(() {
      userData = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
          ? const Center(child: Text("User data not found"))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userData!['fullName'] ?? ''}",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${userData!['email'] ?? ''}",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Spacer(),

                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            padding: EdgeInsets.all(10),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_none_outlined,
                            size: 27,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                        ),
                      ],
                    ),

                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(Icons.account_circle_outlined, size: 28),

                        Text("Account edit", style: TextStyle(fontSize: 20)),
                        Spacer(),

                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            padding: EdgeInsets.all(10),
                          ),

                          onPressed: () {},
                          icon: Icon(Icons.edit_note_outlined, size: 27),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.g_translate_sharp,
                            color: Colors.black,
                          ),
                          title: Text(
                            "Language",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),

                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),

                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.chat_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            "FeedBack",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),

                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),

                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.star_border_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                          title: Text(
                            "Reate Us",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),

                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),

                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            "NEw Version",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),

                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 5,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await context.read<UserProvider>().logOut(context);
                      },
                      child: Text("Logout", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
