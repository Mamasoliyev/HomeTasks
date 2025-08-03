import 'package:cinemax/cure/utils/app_colors.dart';
import 'package:cinemax/cure/utils/app_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestGridView extends StatefulWidget {
  const TestGridView({super.key});

  @override
  State<TestGridView> createState() => _TestGridViewState();
}

class _TestGridViewState extends State<TestGridView>
    with SingleTickerProviderStateMixin {
  List<String> imagePath = [
    AppSvgs.picture1Image,
    AppSvgs.picture2Image,
    AppSvgs.picture3Image,
    AppSvgs.picture4Image,
  ];
  List<String> textpath = [
    "Brown Jacket",
    "Brown Suite",
    "Brown Jacket",
    "Brown Shirt",
  ];

  List<bool> likedItems = List.generate(4, (index) => false);

  List<String> gradepath = ["4.9", "5.0", "4.9", "5.0"];
  List<String> pricepath = ["\$ 83.97", "\$ 120.00", "\$ 83.97", "\$ 120.00"];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          int countColumn = constraints.maxWidth > 550 ? 4 : 3;
          return GridView.count(
            crossAxisCount: countColumn,
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                imagePath[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      likedItems[index] = !likedItems[index];
                                    });
                                  },
                                  icon: likedItems[index]
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 20,
                                        )
                                      : Icon(Icons.favorite_border, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(textpath[index], style: TextStyle(fontSize: 10)),
                        Spacer(),
                        Icon(Icons.star, color: Colors.orange),
                        Text(gradepath[index]),
                      ],
                    ),
                    Row(children: [Text(pricepath[index])]),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
