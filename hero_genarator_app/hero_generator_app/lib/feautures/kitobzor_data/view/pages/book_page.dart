import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view_models/banner_provider.dart';
import 'package:provider/provider.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BannerProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<BannerProvider>(context, listen: false);
    // provider.loadBooks(
    //   // categoryId: 1, subCategoryId: 1
    //   );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Kitoblar",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<BannerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // if (provider.books.isEmpty) {
          //   return Center(
          //     child: Text(
          //       "Kitoblar topilmadi",
          //       style: GoogleFonts.poppins(fontSize: 16.sp),
          //     ),
          //   );
          // }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: GridView.builder(
              itemCount: provider.books.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final book = provider.books[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                          child: Image.network(
                            book.picture ?? 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.name ?? 'Noma\'lum kitob',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              book.author ?? 'Noma\'lum muallif'  ,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "${book.price} so'm",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
