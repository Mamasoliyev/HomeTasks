import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _otpText = ""; // ✅ UI uchun OTP ni string ko'rinishida saqlaymiz

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tasdiqlash kodi",
                style: GoogleFonts.poppins(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Telefon raqamingizga yuborilgan 6 xonali kodni kiriting",
                style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              // ✅ OTP Input
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Hidden TextField (klaviatura uchun)
                    Opacity(
                      opacity: 0.0,
                      child: TextField(
                        controller: _otpController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            _otpText = value; // ✅ UI uchun string
                          });
                        },
                      ),
                    ),
                    // OTP Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 48.w,
                          height: 58.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            index < _otpText.length ? _otpText[index] : "",
                            style: GoogleFonts.poppins(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60.h),

              // ✅ BlocConsumer bilan state kuzatish
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserSignedUp) {
                    context.go('/navigation'); // ✅ Token olgach Home ga o'tish
                  } else if (state is UserError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const CircularProgressIndicator();
                  }
                  return SizedBox(
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
                        if (_otpText.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Kod to'liq kiritilmadi!"),
                            ),
                          );
                        } else {
                          final (otpInt) = int.tryParse(_otpText) ?? 0;
                          context.read<UserBloc>().add(
                            SignupEvent((widget.phoneNumber), (otpInt)),
                          );
                        }
                      },
                      child: Text(
                        "Tasdiqlash",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
