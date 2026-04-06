import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryItem {
  final String content;
  final DateTime timestamp;

  HistoryItem({required this.content, required this.timestamp});

  // Converts the item to a format the phone can save
  Map<String, dynamic> toJson() => {
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  // Loads the item back from the phone's memory
  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}

class HistoryService {
  static const String _key = 'qr_history_list';

  // AUTOMATIC SAVE: Call this whenever a QR is scanned or generated
  static Future<void> saveItem(String content) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyJson = prefs.getStringList(_key) ?? [];
    
    final newItem = HistoryItem(
      content: content,
      timestamp: DateTime.now(),
    );

    // Add newest items to the top
    historyJson.insert(0, jsonEncode(newItem.toJson())); 
    await prefs.setStringList(_key, historyJson);
  }

  // LOAD ALL: Gets the list for the History Page
  static Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyJson = prefs.getStringList(_key) ?? [];
    return historyJson.map((item) => HistoryItem.fromJson(jsonDecode(item))).toList();
  }

  // DELETE: Removes a single item by its index
  static Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyJson = prefs.getStringList(_key) ?? [];
    if (index >= 0 && index < historyJson.length) {
      historyJson.removeAt(index);
      await prefs.setStringList(_key, historyJson);
    }
  }
}