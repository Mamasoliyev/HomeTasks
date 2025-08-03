import 'package:flutter/material.dart';

class ActorScreen extends StatelessWidget {
  ActorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1D2B),
        title: Expanded(
          child: Container(
            // margin: EdgeInsets.only(left: 20),
            // width: 276,
            height: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFF252836),
            ),
            child: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.search, color: Colors.white, size: 20),
                SizedBox(width: 16),

                Text(
                  "John",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Text(
            "Cancel",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: "Montserrat",
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Actors",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "Montserrat",
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 15,
              children: [
                buildAvatar(
                  path: "assets/images/man1.png",
                  text: "John Wilson",
                ),
                buildAvatar(path: "assets/images/man2.png", text: "John Deere"),
                buildAvatar(path: "assets/images/man3.png", text: "John Cena"),
                buildAvatar(path: "assets/images/man4.png", text: "John Stamo"),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Movie Related",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    Spacer(),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF12CDD9),
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  spacing: 15,
                  children: [
                    Stack(
                      children: [
                        Image.asset("assets/images/spiderman.png"),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Image.asset("assets/images/rate.png"),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFF8700),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            " Premium ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        Text(
                          "Spider-Man No Way.. ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Icon(Icons.date_range, color: Color(0xFF92929D)),
                            Text(
                              "2021",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Icon(Icons.timer, color: Color(0xFF92929D)),
                            Text(
                              "148 minites",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.movie_creation,
                              color: Color(0xFF92929D),
                            ),
                            Text(
                              "Action |",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: "Montserrat",
                              ),
                            ),
                            Text(
                              "Movie",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildAvatar({required String path, required String text}) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(radius: 30, child: Image.asset(path)),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
