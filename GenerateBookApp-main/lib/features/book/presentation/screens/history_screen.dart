import 'package:ai_book_summary_app/features/book/presentation/controller/book_controller.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

enum HistorySort { newest, rating }

class _HistoryScreenState extends State<HistoryScreen> {
  late final BookController c;
  final _searchCtrl = TextEditingController();
  HistorySort _sort = HistorySort.newest;

  @override
  void initState() {
    super.initState();
    c = Get.find<BookController>();
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<dynamic> _filtered() {
    final q = _searchCtrl.text.trim().toLowerCase();
    final list = c.summaries.toList();

    // Filter
    final filtered = q.isEmpty
        ? list
        : list.where((e) {
            final title = (e.title ?? e.title ?? '').toString().toLowerCase();
            final author = (e.author ?? '').toString().toLowerCase();
            final summary = (e.summary ?? '').toString().toLowerCase();
            return title.contains(q) ||
                author.contains(q) ||
                summary.contains(q);
          }).toList();

    // Sort
    if (_sort == HistorySort.rating) {
      filtered.sort((a, b) {
        final ar = (a.rating is int)
            ? a.rating as int
            : int.tryParse('${a.rating}') ?? 0;
        final br = (b.rating is int)
            ? b.rating as int
            : int.tryParse('${b.rating}') ?? 0;
        return br.compareTo(ar); // high → low
      });
    } else {
      // Newest (assumes append order = newest last)
      // If you have a createdAt, sort by that instead.
      filtered.sort((_, __) => 0); // keep current order
    }
    return filtered;
  }

  void _confirmClearAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear history?'),
        content: const Text('This will remove all saved summaries.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (ok == true) c.clearAll();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('History'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: _confirmClearAll,
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear all',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search + sort
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search by title, author, or text',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  PopupMenuButton<HistorySort>(
                    tooltip: 'Sort',
                    onSelected: (v) => setState(() => _sort = v),
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: HistorySort.newest,
                        child: ListTile(
                          leading: Icon(Icons.schedule),
                          title: Text('Newest'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: HistorySort.rating,
                        child: ListTile(
                          leading: Icon(Icons.star),
                          title: Text('Highest rating'),
                        ),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _sort == HistorySort.rating
                                ? Icons.star
                                : Icons.schedule,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _sort == HistorySort.rating ? 'Rating' : 'Newest',
                          ),
                          const Icon(Icons.expand_more, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: Obx(() {
                if (c.summaries.isEmpty) {
                  return _EmptyHistory(theme: theme);
                }

                final items = _filtered();
                if (items.isEmpty) {
                  return const Center(child: Text('No results found'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final e = items[i];

                    final String title = (e.title ?? e.title ?? '').toString();
                    final String author = (e.author ?? '').toString();
                    final String summary = (e.summary ?? '').toString();
                    final int rating = (e.rating is int)
                        ? e.rating as int
                        : int.tryParse('${e.rating}') ?? 0;

                    return Dismissible(
                      key: ValueKey('hist_${title}_$i'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                      onDismissed: (_) {
                        // Remove from original list (not from filtered clone)
                        c.deleteSummary(e);
                      },
                      child: _HistoryTile(
                        title: title,
                        author: author,
                        summary: summary,
                        rating: rating.clamp(0, 5),
                        onTap: () {
                          // Optionally navigate to a details page
                          // Get.toNamed('/summary_detail', arguments: e);
                        },
                        onShare: () {
                          final text =
                              '$title${author.isNotEmpty ? " — $author" : ""}\n'
                              'Rating: ${"★" * rating}\n\n$summary';
                          // Share.share(text); // if using share_plus
                          Get.snackbar(
                            'Copied',
                            'Share logic here',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history_toggle_off, size: 72),
            const SizedBox(height: 12),
            Text('No history yet', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Your summarized books will appear here.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.title,
    required this.author,
    required this.summary,
    required this.rating,
    required this.onTap,
    required this.onShare,
  });

  final String title;
  final String author;
  final String summary;
  final int rating;
  final VoidCallback onTap;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading icon/avatar
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    height: 150,
                    width: 110,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    "https://image.pollinations.ai/prompt/$summary",
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Texts
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + actions
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            title.isEmpty ? 'Untitled' : title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Spacer(),

                        IconButton(
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            minimumSize: Size(0, 0),
                          ),

                          onPressed: onShare,
                          icon: const Icon(Icons.ios_share_outlined, size: 20),
                          tooltip: 'Share',
                        ),
                      ],
                    ),
                    if (author.isNotEmpty)
                      Text(
                        author,
                        style: theme.textTheme.bodyMedium,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    // Stars
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < rating
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 18,
                          color: const Color.fromARGB(255, 255, 115, 0),
                        ),
                      ),
                    ),
                    // Summary preview
                    Text(
                      summary,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
