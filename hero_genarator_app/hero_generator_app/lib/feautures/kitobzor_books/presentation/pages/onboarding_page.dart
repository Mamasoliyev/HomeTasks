import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/widgets/build_main_button_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  String _selectedLanguage = 'O‘zbek tili';

  final List<String> images = [
    'assets/images/onboarding1.jpg',
    'assets/images/onboarding2.jpg',
    'assets/images/onboarding3.jpg',
  ];

  final List<String> text1 = [
    "Xush kelibsiz",
    "Kitoblarni Izlang va Ulashing",
    "O‘qishni Boshlang",
  ];

  final List<String> text2 = [
    "Kitobzor orqali kitoblarni toping, ulashing va yangi kitoblar bilan tanishing!",
    "O‘zingiz yoqtirgan kitoblarni yuklang yoki mavjud kutubxonadan oling.",
    "Sevimli kitoblaringizni onlayn o‘qib, bilim dunyosiga sho‘ng‘ing!",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ✅ Responsive Image Slider
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 320.h),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(16.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // ✅ Dots Indicator
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (dotIndex) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 6.h,
                        width: _currentIndex == dotIndex ? 24.w : 12.w,
                        decoration: BoxDecoration(
                          color: _currentIndex == dotIndex
                              ? Colors.blueAccent
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // ✅ Bottom Content
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          text1[_currentIndex],
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          text2[_currentIndex],
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),

                        // ✅ Buttons Row
                        Row(
                          children: [
                            Expanded(
                              child: MainButton(
                                text: "Skip",
                                textColor: Colors.black,
                                color: const Color(0xFFF9FAFB),
                                onPressed: () {
                                  context.go('/signup');
                                },
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: MainButton(
                                text: _currentIndex == images.length - 1
                                    ? "Get Started"
                                    : "Next",
                                textColor: Colors.white,
                                color: Colors.blueAccent,
                                onPressed: () {
                                  if (_currentIndex < images.length - 1) {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    context.go('/signup');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ✅ Language Selector (Top Right)
            Positioned(
              right: 22.w,
              top: 22.h,
              child: Container(
                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.blueAccent, width: 1.w),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    icon: Icon(Icons.language, size: 18.sp),
                    items: ['O‘zbek tili', 'Ingliz tili', 'Rus tili']
                        .map(
                          (lang) => DropdownMenuItem(
                            value: lang,
                            child: Text(
                              lang,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedLanguage = val;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
