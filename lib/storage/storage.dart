import 'package:shared_preferences/shared_preferences.dart';
import 'counter.dart';

class StorageService {
  static const String _counterKey = 'counter_key';

  Future<void> saveCounter(CounterModel counter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_counterKey, counter.count);
  }

  Future<CounterModel> loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_counterKey) ?? 0;
    return CounterModel(count: count);
  }
}