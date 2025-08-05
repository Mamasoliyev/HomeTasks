import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/cubit/user_cubit.dart';
import 'package:provider/provider.dart';
import '../../../kitobzor_data/models/banner_model.dart';
import '../../../kitobzor_data/view_models/banner_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BannerProvider>(context, listen: false).loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Kitobzor",
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        //Logout button
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Call the logout method from UserCubit
              try {
                context.read<UserCubit>().logout();
                Navigator.pushReplacementNamed(context, '/signup');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: $e')),
                );
              }
            },
          ),
        ],
      ),
      
      body: Consumer<BannerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text(provider.error!));
          } else if (provider.banners.isEmpty && provider.categories.isEmpty) {
            return const Center(child: Text("Ma'lumotlar topilmadi"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Banner Carousel
                CarouselSlider.builder(
                  itemCount: provider.banners.length,
                  itemBuilder: (context, index, realIndex) {
                    BannerModel banner = provider.banners[index];
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            banner.picture,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Text(
                          banner.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    height: 180.h,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 12.h),

                // ✅ Banner Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    provider.banners.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: _currentIndex == index ? 16.w : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.blueAccent
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // ✅ Category Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Kategoriyalar",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // ✅ Category Grid
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            '/subcategory/${category.id}/${Uri.encodeComponent(category.name)}',
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                category.picture,
                                height: 70.h,
                                width: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              category.name,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
