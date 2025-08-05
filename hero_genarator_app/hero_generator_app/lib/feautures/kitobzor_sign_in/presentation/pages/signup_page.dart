import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(
    text: "+998",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ro'yxatdan o'tish",
                style: GoogleFonts.poppins(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Ma'lumotlaringizni kiriting",
                style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      firstNameController,
                      "Ismingiz",
                      Icons.person,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      lastNameController,
                      "Familiyangiz",
                      Icons.person_outline,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      phoneController,
                      "Telefon raqami",
                      Icons.phone,
                      isPhone: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/otp', extra: phoneController.text.trim()); // ✅ OTP screen
                    }
                  },
                  child: Text(
                    "Davom etish",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // MainButton(
              //   color: Colors.blueAccent,
              //   text: "Davom etish",
              //   textColor: Colors.white,

              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       context.go('/otp'); // ✅ OTP screen
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isPhone = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: TextStyle(fontSize: 16.sp),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$hint ni kiriting";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
      ),
    );
  }
}
