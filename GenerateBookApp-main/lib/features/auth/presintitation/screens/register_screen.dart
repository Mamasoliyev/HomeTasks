// import 'package:ai_book_summary_app/features/auth/presintitation/controller/auht_controller.dart';
// import 'package:ai_book_summary_app/features/book/presentation/screens/book_summary_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/route_manager.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   final controller = Get.find<AuthController>();

//   @override
//   void dispose() {
//     super.dispose();

//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(backgroundColor: Colors.white),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Sign Up",
//                 style: TextStyle(
//                   fontSize: 25,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),

//               Text(
//                 "Create account and choose, fovourite menu",
//                 style: TextStyle(color: Colors.blueGrey),
//               ),

//               Text(
//                 "Name",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),

//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(color: Colors.blueGrey),

//                   hintText: "Your name",
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: EdgeInsets.all(15),
//                 ),
//               ),

//               Text(
//                 "Email",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),

//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(color: Colors.blueGrey),

//                   hintText: "Your email",
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: EdgeInsets.all(15),
//                 ),
//               ),

//               Text(
//                 "Password",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),

//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(color: Colors.blueGrey),

//                   hintText: "Your password",
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: EdgeInsets.all(15),
//                 ),
//               ),

//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Forgot password?",
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),

//               Obx(
//                 () => ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 55),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     backgroundColor: Colors.black,
//                     elevation: 0,
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () async {
//                     controller.isLoading.value = true;

//                     try {
//                       await controller.register(
//                         emailController.text.trim(),
//                         passwordController.text.trim(),
//                       );

//                       if (!mounted) return;

//                       Get.offAll(() => SummaryScreen());
//                     } catch (e) {
//                       if (!mounted) return;

//                       Get.snackbar("Error", e.toString());
//                     } finally {
//                       if (!mounted) return;

//                       controller.isLoading.value = false;
//                     }
//                   },
//                   child: controller.isLoading.value
//                       ? Center(
//                           child: CircularProgressIndicator(color: Colors.white),
//                         )
//                       : Text("Register", style: TextStyle(fontSize: 17)),
//                 ),
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     " Have an account?",
//                     style: TextStyle(color: Colors.blueGrey),
//                   ),

//                   TextButton(
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.all(5),
//                       minimumSize: Size(0, 0),
//                     ),
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text(
//                       "Sign in",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 10),
//               //   child: ElevatedButton(
//               //     style: ElevatedButton.styleFrom(
//               //       foregroundColor: Colors.black,
//               //       backgroundColor: Colors.white,
//               //       elevation: 0,
//               //       minimumSize: Size(0, 50),
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(10),
//               //         side: BorderSide(color: Colors.blueGrey),
//               //       ),
//               //     ),
//               //     onPressed: () {},
//               //     child: Row(
//               //       spacing: 6,
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       children: [
//               //         Icon(Icons.facebook, size: 25, color: Colors.blue),
//               //         Text("Sign in with Facebook"),
//               //       ],
//               //     ),
//               //   ),
//               // ),

//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 10),
//               //   child: ElevatedButton(
//               //     style: ElevatedButton.styleFrom(
//               //       foregroundColor: Colors.black,
//               //       backgroundColor: Colors.white,
//               //       elevation: 0,
//               //       minimumSize: Size(0, 50),
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(10),
//               //         side: BorderSide(color: Colors.blueGrey),
//               //       ),
//               //     ),
//               //     onPressed: () {},
//               //     child: Row(
//               //       spacing: 6,
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       children: [
//               //         Icon(Icons.apple, size: 25),
//               //         Text("Sign in with Apple"),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               SizedBox(height: 100),
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       "By clicking Register, you agree to our",
//                       style: TextStyle(color: Colors.blueGrey),
//                     ),
//                     Text("Terms and Data Policy"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ai_book_summary_app/features/auth/presintitation/controller/auht_controller.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/book_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ro‘yxatdan o‘tish",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Hisob yarating va sevimli menyuni tanlang",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Text(
                  "Ism",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    hintText: "Ismingiz",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos, ismingizni kiriting";
                    }
                    return null;
                  },
                ),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    hintText: "Emailingiz",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos, emailingizni kiriting";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Iltimos, to‘g‘ri email kiriting";
                    }
                    return null;
                  },
                ),
                Text(
                  "Parol",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    hintText: "Parolingiz",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos, parolingizni kiriting";
                    }
                    if (value.length < 6) {
                      return "Parol kamida 6 belgidan iborat bo‘lishi kerak";
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Parolni unutdingizmi?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black,
                      elevation: 0,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await controller.register(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (mounted) {
                            Get.offAll(() => SummaryScreen());
                          }
                        } catch (e) {
                          if (mounted) {
                            Get.snackbar("Xato", e.toString());
                          }
                        }
                      }
                    },
                    child: controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Ro‘yxatdan o‘tish",
                            style: TextStyle(fontSize: 17),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hisobingiz bormi?",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        minimumSize: Size(0, 0),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Kirish",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Ro‘yxatdan o‘tish tugmasini bosish orqali siz bizning",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        "Foydalanish shartlari va Ma’lumotlar siyosatiga rozilik bildirasiz",
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
  }
}
