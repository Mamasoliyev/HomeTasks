import 'package:cinemax/cure/utils/app_colors.dart';
import 'package:cinemax/cure/utils/app_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          spacing: 10.sp,
          children: [
            Icon(Icons.arrow_back_ios_outlined),
            SizedBox(width: 70.w),
            Text("Codefive"),
            Icon(Icons.check_circle, color: Colors.blue),
            Spacer(),
            Icon(Icons.notifications_none),
            Icon(Icons.more_horiz),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset(AppSvgs.picture5Image),
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Row(
                        spacing: 45.sp,
                        children: [
                          Text(
                            "6956",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "27,7m",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "219",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 15,
                        children: [
                          Text(
                            "Publicacoes",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Seguidores",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "A suguir",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text("Codefive"),
              Text(
                "Agenica",
                style: TextStyle(color: AppColors.whiteGreyColor),
              ),
              Text(
                "O seu site de sonhos ,esta no sitio certo 📺 \n codefive.pt",
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.blue,
                    child: ClipOval(
                      child: Image.asset(
                        AppSvgs.picture2Image,
                        fit: BoxFit.cover,
                        width: 60.w,
                        height: 60.h,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: ClipOval(
                      child: Image.asset(
                        AppSvgs.picture3Image,
                        fit: BoxFit.cover,
                        width: 60.w,
                        height: 60.w,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.blue,
                    child: ClipOval(
                      child: Image.asset(
                        AppSvgs.picture4Image,
                        fit: BoxFit.cover,
                        width: 60.w,
                        height: 60.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  RichText(
                    text: TextSpan(
                      text: "Seguido por",
                      style: TextStyle(
                        color: AppColors.whiteGreyColor,
                        fontSize: 10,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "joaocorreia09, vanda.carvalho e\n 16 outros amigos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Seguir",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  OutlinedButton(onPressed: () {}, child: Text("Mensagem")),
                  OutlinedButton(onPressed: () {}, child: Text("Contactar")),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteGreyColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.person_add),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10.sp,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.lightbulb_outline,
                                size: 40,
                                color: Colors.yellowAccent,
                              ),
                            ),
                          ),
                        ),
                        Text("Design Tips", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.cases_outlined,
                                size: 40,
                                color: Colors.yellowAccent,
                              ),
                            ),
                          ),
                        ),
                        Text("Portfolio", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.grid_view_rounded,
                                size: 40,
                                color: Colors.yellowAccent,
                              ),
                            ),
                          ),
                        ),
                        Text("Resources", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.ads_click_outlined,
                                size: 40,
                                color: Colors.yellowAccent,
                              ),
                            ),
                          ),
                        ),
                        Text("UI Basics", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.web,
                                size: 40,
                                color: Colors.yellowAccent,
                              ),
                            ),
                          ),
                        ),
                        Text("Web Design", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 450.h,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5
                  ),
                  scrollDirection: Axis.vertical,

                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture4Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture3Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture1Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture2Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture4Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture3Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture1Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture2Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture4Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture3Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture1Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture2Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture4Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture3Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture1Image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppSvgs.picture2Image),
                          fit: BoxFit.cover,
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
    );
  }
}
