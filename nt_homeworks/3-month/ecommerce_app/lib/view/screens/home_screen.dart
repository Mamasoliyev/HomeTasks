import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showRecommended = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text("Tabiat Bloglari"),
              background: Image.network(
                'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcScncvHHA59gx3Iri_Jxb0ZuwOkY-e8OkvCp10Jzr2S8HfcM_7J',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _StickyTabBarDelegate(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton("Barchasi", !showRecommended),
                    const SizedBox(width: 10),
                    _buildToggleButton("Tavsiya etilgan", showRecommended),
                  ],
                ),
              ),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _StickyTabBarDelegate(
              child: Container(
                width: double.infinity,
                height: 100,
                // 👈 bu qo‘shildi
                // matnni markazga olish uchun
                color: Colors.white,
                child: const Text("data"),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildListDelegate([
                _buildBlogCard(
                  title: "O‘rmon Sayohatlari",
                  imagePath:
                      "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSsarzhNwoMx8BWjuOsFf8tKIAunLsrXmB8cl8pys5ueYTxV2N6",
                ),
                _buildBlogCard(
                  title: "O‘tloqlarning G‘arbiy Tomoni",
                  imagePath:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfJZY92ebk8V-HOTT803G4QRWtbOcLPDJgI5on-VwtPW9bWmcI",
                ),
                _buildBlogCard(
                  title: "O‘rmon Sayohatlari",
                  imagePath:
                      "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSsarzhNwoMx8BWjuOsFf8tKIAunLsrXmB8cl8pys5ueYTxV2N6",
                ),
                _buildBlogCard(
                  title: "O‘tloqlarning G‘arbiy Tomoni",
                  imagePath:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfJZY92ebk8V-HOTT803G4QRWtbOcLPDJgI5on-VwtPW9bWmcI",
                ),
              ]),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
              ),
              delegate: SliverChildListDelegate([
                _buildCategoryCard(
                  Icons.local_florist,
                  "O‘simlik turlari",
                  Colors.green.shade100,
                ),
                _buildCategoryCard(
                  Icons.pets,
                  "Hayvonot olami",
                  Colors.blue.shade100,
                ),
                _buildCategoryCard(
                  Icons.local_florist,
                  "O‘simlik turlari",
                  Colors.green.shade100,
                ),
                _buildCategoryCard(
                  Icons.pets,
                  "Hayvonot olami",
                  Colors.blue.shade100,
                ),
                _buildCategoryCard(
                  Icons.local_florist,
                  "O‘simlik turlari",
                  Colors.green.shade100,
                ),
                _buildCategoryCard(
                  Icons.pets,
                  "Hayvonot olami",
                  Colors.blue.shade100,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => showRecommended = (text == "Tavsiya etilgan"));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlogCard({required String title, required String imagePath}) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(imagePath, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 12,
          bottom: 55,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          // left: 12,
          bottom: 12,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: const Text("O‘qishni davom ettirish"),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(IconData icon, String label, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 99;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
