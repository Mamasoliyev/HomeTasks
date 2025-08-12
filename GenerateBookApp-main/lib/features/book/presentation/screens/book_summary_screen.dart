import 'package:ai_book_summary_app/core/app/di/injection_container.dart';
import 'package:ai_book_summary_app/features/book/presentation/controller/book_controller.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _titleCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final BookController c;

  @override
  void initState() {
    super.initState();
    c = Get.put<BookController>(locator<BookController>());
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    super.dispose();
  }

  void _summarize() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    try {
      await c.getBookSummary(
        book: _titleCtrl.text.trim(),
        author: _authorCtrl.text.trim(),
      );
    } catch (e) {
      Get.snackbar(
        'Xatolik',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // controller should set isLoading=false itself;
      // if not, you can also toggle here.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Generation Book',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/history'),
            icon: const Icon(Icons.history),
            tooltip: 'History',
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              // Input card
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0),

                          borderRadius: BorderRadius.circular(10),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0),

                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: const Color.fromARGB(255, 239, 182, 238),
                        border: InputBorder.none,
                        labelText: 'Book title',
                        hintText: 'e.g. Atomic Habits',
                        prefixIcon: const Icon(Icons.menu_book_rounded),
                      ),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _authorCtrl,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0),

                          borderRadius: BorderRadius.circular(10),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: const Color.fromARGB(255, 125, 132, 235),
                        border: InputBorder.none,

                        labelText: 'Author (optional)',
                        hintText: 'e.g. James Clear',
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Result card
              Obx(() {
                if (c.summaries.isEmpty) {
                  return _EmptyState(theme: theme);
                }
                final last = c.summaries.last;

                final String book = (last.author).toString();
                final String author = (last.title).toString();
                final String summary = (last.summary ?? '').toString();
                final int rating = (last.rating is int)
                    ? last.rating!
                    : int.tryParse('${last.rating}') ?? 0;

                return _ResultCard(
                  title: book,
                  author: author,
                  summary: summary,
                  rating: rating.clamp(0, 5),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.only(left: 40, right: 8),
        child: Obx(() {
          return TextButton.icon(
            onPressed: c.isLoading.value ? null : () => _summarize(),
            icon: c.isLoading.value
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome, color: Colors.amber),
            label: c.isLoading.value
                ? const Text('Summarizing...')
                :
                  // : ShaderMask(
                  //     shaderCallback: (Rect bounds) {
                  //       return const LinearGradient(
                  //         colors: <Color>[
                  //           Color.fromARGB(255, 215, 0, 253),
                  //           Color.fromARGB(255, 136, 127, 255),
                  //           Color.fromARGB(255, 24, 251, 255),
                  //         ],
                  //       ).createShader(bounds);
                  //     },
                  //     blendMode: BlendMode.srcIn,
                  //  child:
                  const Text(
                    'Summarize',
                    style: TextStyle(
                      color: Colors.white, // bu bo‘yalmaydi, shader ishlaydi
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

            style: TextButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 10, 0, 16),
              foregroundColor: Colors.white,

              minimumSize: Size(double.infinity, 55),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.menu_book_outlined, size: 80),
          const SizedBox(height: 12),
          Text(
            'Enter a book to get a summary',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Add an author for better accuracy',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.author,
    required this.summary,
    required this.rating,
  });

  final String title;
  final String author;
  final String summary;
  final int rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: const Color.from(alpha: 1, red: 0.929, green: 0.675, blue: 0.675),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Get.to(
                () => DetailScreen(
                  image: "https://image.pollinations.ai/prompt/$summary",
                  title: title,
                  author: author,
                  summary: summary,
                  rating: rating.clamp(0, 5),
                ),
              );
            },

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                // Column(
                //   children: [
                //     Text(
                //       title,
                //       style: theme.textTheme.titleLarge?.copyWith(
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //     if (author.isNotEmpty)
                //       Padding(
                //         padding: const EdgeInsets.only(top: 4.0),
                //         child: Text(author, style: theme.textTheme.bodyMedium),
                //       ),
                //   ],
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                          "https://image.pollinations.ai/prompt/$summary",
                        ),

                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: StarRating(value: rating, size: 22),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  maxLines: 1,
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (author.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(author, style: TextStyle(fontSize: 16)),
                  ),

                //   ],
                // ),
                const SizedBox(height: 12),

                // Container(
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border.all(
                //       color: const Color.fromARGB(255, 76, 6, 88),
                //     ),
                //   ),

                //   child: Text(summary, style: TextStyle(fontSize: 13)),
                // ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int value; // 0..5
  final double size;
  final Color? color;
  const StarRating({
    super.key,
    required this.value,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (i) => Icon(
          i < value ? Icons.star_rounded : Icons.star_border_rounded,
          color: const Color.fromARGB(255, 255, 170, 0),
          size: size,
        ),
      ),
    );
  }
}
