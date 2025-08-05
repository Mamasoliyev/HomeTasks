import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view_models/banner_provider.dart';
import 'package:provider/provider.dart';

class SubCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const SubCategoryPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BannerProvider>(
        context,
        listen: false,
      ).loadSubCategories(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<BannerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text(provider.error!));
          } else if (provider.subCategories.isEmpty) {
            return const Center(child: Text("Subkategoriyalar topilmadi"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: provider.subCategories.length,
            itemBuilder: (context, index) {
              final subCat = provider.subCategories[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  subCat.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
