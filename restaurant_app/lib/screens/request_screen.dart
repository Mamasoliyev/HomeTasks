import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  static String path = "/RequestScreen";
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String imageShow = "assets/svgs/burger.svg";
  String title = "Welcome";
  String subTitle = """Before enjoying Foodmedia services
Please register first""";
  //sing up uchun
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordContrtoller = TextEditingController();

  //Login uchun controllerlar

  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpasswordContrtoller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordContrtoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300, child: SvgPicture.asset(imageShow)),
            Text(
              title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            Text(
              textAlign: TextAlign.center,
              subTitle,
              style: TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),

            SizedBox(height: 60),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(280, 55),
                backgroundColor: Colors.green.shade400,
                foregroundColor: Colors.white,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  showDragHandle: true,
                  context: context,
                  isScrollControlled:
                      true, // klaviatura chiqqanda pastga tushmasligi uchun
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: SingleChildScrollView(
                          child: Consumer<UserProvider>(
                            builder: (context, provider, child) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TabBar(
                                  labelStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  labelColor: Colors.green,
                                  unselectedLabelColor: Colors.grey,

                                  indicatorColor: Colors.green,

                                  dividerColor: Colors.transparent,
                                  tabs: [
                                    Tab(text: "Create Account", height: 30),
                                    Tab(text: "Login"),
                                  ],
                                ),

                                SizedBox(
                                  height: 560,
                                  child: TabBarView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 7,
                                          children: [
                                            textWidget(text: "Full Name"),
                                            TextField(
                                              controller: nameController,
                                              decoration: const InputDecoration(
                                                hintText:
                                                    "Enter your full name",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),

                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            textWidget(text: "Email address"),

                                            TextField(
                                              controller: emailController,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    "Eg namaemail@emailkamu.com",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),

                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            textWidget(text: "Password"),
                                            TextField(
                                              controller: passwordContrtoller,
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                labelText: "**** **** ****",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),

                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  minimumSize: Size(280, 55),
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,

                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusGeometry.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),

                                                onPressed: () async {
                                                  await provider.signUp(
                                                    context,
                                                    fullName: nameController
                                                        .text
                                                        .trim(),
                                                    email: emailController.text
                                                        .trim(),
                                                    password:
                                                        passwordContrtoller.text
                                                            .trim(),
                                                  );
                                                },
                                                child: provider.isLoading
                                                    ? SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      )
                                                    : Text("Registration"),
                                              ),
                                            ),
                                            Center(
                                              child: provider.error.isNotEmpty
                                                  ? Text(
                                                      provider.error,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      width: 120,
                                                      child: Divider(),
                                                    ),
                                            ),

                                            Center(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  minimumSize: Size(280, 55),
                                                  backgroundColor:
                                                      Colors.grey.shade100,
                                                  foregroundColor: Colors.black,

                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusGeometry.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),

                                                onPressed: () async {
                                                  // Google bilan sign in
                                                  final GoogleSignInAccount?
                                                  googleUser =
                                                      await GoogleSignIn.instance.authenticate(scopeHint: [
                                                        
                                                      ]);
                                                        ;
                                                  if (googleUser == null)
                                                    return; // foydalanuvchi bekor qildi

                                                  final GoogleSignInAuthentication
                                                  googleAuth = googleUser
                                                      .authentication;

                                                  final credential =
                                                      GoogleAuthProvider.credential(
                                                        accessToken:
                                                            googleAuth.idToken,
                                                        idToken:
                                                            googleAuth.idToken,
                                                      );

                                                  final userCredential =
                                                      await FirebaseAuth
                                                          .instance
                                                          .signInWithCredential(
                                                            credential,
                                                          );

                                                  // Natija ko‘rsatish
                                                  final user =
                                                      userCredential.user;
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "Xush kelibsiz, ${user?.displayName}!",
                                                      ),
                                                    ),
                                                  );
                                                },

                                                child: Row(
                                                  spacing: 7,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.g_mobiledata,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                    Text("Sign up with Google"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Login form
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: SafeArea(
                                          child: Column(
                                            spacing: 7,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              textWidget(text: "Email address"),

                                              TextField(
                                                controller:
                                                    loginemailController,
                                                decoration: const InputDecoration(
                                                  labelText:
                                                      "Eg namaemail@emailkamu.com",
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                    ),

                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(15),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),

                                              textWidget(text: "Password"),
                                              TextField(
                                                controller:
                                                    loginpasswordContrtoller,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText:
                                                          "**** **** ****",
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                        ),

                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                15,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Forgot Passwors?",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Center(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    minimumSize: Size(280, 55),
                                                    backgroundColor:
                                                        Colors.green,
                                                    foregroundColor:
                                                        Colors.white,

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),

                                                  onPressed: () {
                                                    provider.signIn(
                                                      context,
                                                      email:
                                                          loginemailController
                                                              .text
                                                              .trim(),
                                                      password:
                                                          loginpasswordContrtoller
                                                              .text
                                                              .trim(),
                                                    );
                                                  },
                                                  child: provider.isLoading
                                                      ? SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        )
                                                      : Text("Login"),
                                                ),
                                              ),
                                              Center(
                                                child:
                                                    provider
                                                        .signInError
                                                        .isNotEmpty
                                                    ? Text(
                                                        provider.signInError,
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: 120,
                                                        child: Divider(),
                                                      ),
                                              ),

                                              Center(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    minimumSize: Size(280, 55),
                                                    backgroundColor:
                                                        Colors.grey.shade100,
                                                    foregroundColor:
                                                        Colors.black,

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),

                                                  onPressed: () {},
                                                  child: Row(
                                                    spacing: 7,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.g_mobiledata,
                                                        color: Colors.red,
                                                        size: 30,
                                                      ),
                                                      Text(
                                                        "Sign up with Google",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text("Create Account"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: Size(280, 55),
                backgroundColor: Colors.green.shade100,
                foregroundColor: Colors.green,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              onPressed: () {
                (onClosing: () {}, builder: (context) => Column(children: [
                       
                      ],
                    ));
              },
              child: Text("Login"),
            ),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By logging in or registering, you have agreed To ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),

                children: [
                  TextSpan(
                    text: "The Terms And Conditions",
                    style: TextStyle(color: Colors.green),
                  ),

                  TextSpan(text: " And "),

                  TextSpan(
                    text: "Privacy Policy .",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text textWidget({required String text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}
