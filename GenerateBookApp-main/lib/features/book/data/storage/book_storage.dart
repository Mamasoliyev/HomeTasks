import 'package:ai_book_summary_app/core/app/typdefs/typedefs.dart';
import 'package:get_storage/get_storage.dart';

class BookStorageService {
  static const String _key = "summaries";
  final GetStorage _box = GetStorage();

  List<DataMap> loadSummaries() {
    final raw = _box.read<List>(_key);
    if (raw == null) return [];
    return raw.cast<DataMap>();
  }

  Future<void> saveSummaries(ListDataMAp data) async {
    await _box.write(_key, data);
  }

  Future<void> clearAll() async {
    await _box.remove(_key);
  }
}
